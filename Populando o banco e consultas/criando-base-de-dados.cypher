CALL apoc.load.directory('*.json') YIELD value
WITH value AS arquivos
ORDER BY arquivos DESC
CALL apoc.load.json(arquivos) YIELD value
UNWIND value.data AS tweet
MERGE (t:Tweet {tweet_id: tweet.id})
ON CREATE SET t += {
    texto: tweet.text,
    criado_em: tweet.created_at,
    lingua: tweet.lang,
    curtidas: tweet.public_metrics.like_count,
    retweets: tweet.public_metrics.retweet_count,
    respostas: tweet.public_metrics.reply_count,
    citacoes: tweet.public_metrics.quote_count,
    autor: tweet.author_id,
    geolocalizacao: tweet.geo.place_id
}
FOREACH (hashtag IN tweet.entities.hashtags |
    MERGE (h:Hashtag {hashtag: apoc.text.replace(apoc.text.clean(hashtag.tag), '[^a-zA-Z0-9]', '')})
    MERGE (h)<-[:POSSUI]-(t)
)
FOREACH (ref_tweet IN tweet.referenced_tweets |
    SET t.tipo_ref = coalesce(t.tipo_ref, []) + [ref_tweet.type],
        t.id_ref = coalesce(t.id_ref, []) + [ref_tweet.id]
);
MATCH (t) WHERE "retweeted" in t.tipo_ref
REMOVE t:Tweet
SET t:Retweet;
MATCH (t) WHERE "replied_to" in t.tipo_ref
REMOVE t:Tweet
SET t:Replied_to;
MATCH (t) WHERE "quoted" in t.tipo_ref
REMOVE t:Tweet
SET t:Quot;
CREATE (a:Aluno {nome: "Werricsson Santos"}) -[:RU]-> (r:numeroRU {RU: 4231021});