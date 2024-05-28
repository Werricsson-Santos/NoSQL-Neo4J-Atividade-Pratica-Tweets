MATCH (h:Hashtag) <-[:POSSUI]- (t:Tweet)
WITH h.hashtag as tag, COUNT(t) AS Frequencia
ORDER BY Frequencia DESC LIMIT 1
Match (t:Tweet) -[:POSSUI]-> (h:Hashtag)
Match (a:Aluno) -[:RU]-> (r:numeroRU)
WHERE tag in h.hashtag AND date(t.criado_em) = date("2020-03-05")
RETURN t, h, a, r