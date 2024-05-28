MATCH (h:Hashtag)<-[:POSSUI]-(t:Tweet)
MATCH (a:Aluno)
WITH h, COUNT(t) AS Frequencia, a.nome + " - RU " + a.RU as NomeRU
RETURN h.hashtag AS Hashtag, Frequencia, NomeRU
ORDER BY Frequencia DESC LIMIT 5