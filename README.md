<h1 style="text-align: center"> Atividade Prática NoSQL </h1>
<h3>Siga as etapas abaixo para poder testar os códigos e gerar as imagens:</h3>
<ul>
    <li>Instale o Neo4J, crie um banco de dados local na versão 4.4.5 para que o APOC funcione corretamente.</li>
    <li>Instale a biblioteca APOC no banco de dados que acabou de criar.</li>
    <li>Após a instalação da biblioteca, vá até a pasta "conf" do bd que criou, crie um arquivo chamado "apoc.conf", abra-o com um editor de textos e insira o seguinte código -> "apoc.import.file.enabled=true".</li>
    <li>Selecione a amostragem de dados (tweets) que deseja na pasta zip deste repositório e extraia os arquivos JSON para a pasta import do seu bd. <br> (Os resultados e consultas que fiz, foi utilizando a base inteira. Dependendo da amostragem que for utilizar, você precisará remover o filtro de data da criação do tweet quando for gerar a imagem da atividade 1 e o tweet mais retweetado pode ser outro...)</li>
    <li>Após ter seguido todas as etapas anteriores, você está pronto para acessar a pasta "Populando o banco e consultas" e testar os códigos cypher.</li>
</ul>

<hr>

<h2 style="text-align: center">Questão 01 - DESCOBERTA DA HASHTAG PRINCIPAL</h2>
<h5 style="text-align: center">Como indicado na imagem abaixo a hashtag principal é #issoaglobonaomostra.</h5>
<div style="text-align: center">
    <image src="./assets/resposta-atividade1.png" alt="Imagem de grafos contendo a hashtag principal e alguns tweets que possuem essa hashtag">
</div>

<hr>

<h2 style="text-align: center">Questão 02 - ANÁLISE DOS DADOS SEGUNDO VIÉS A SUA ESCOLHA</h2>
<h5 style="text-align: center">Escolhi buscar o tweet mais retweetado. A imagem abaixo mostra qual é esse tweet que inclusive contém a hashtag principal mostrada na atividade 1.</h5>

<div style="text-align: center">
    <image src="./assets/resposta-atividade2.png" alt="Imagem de grafos contendo o tweet mais retweetado com alguns desses retweets.">
</div>


<h5 style="text-align: center">Para visualizar o trabalho na integra acesse a página assets ou <a href="https://github.com/Werricsson-Santos/NoSQL-Neo4J-Atividade-Pratica-Tweets/blob/master/assets/Caderno%20de%20Resolucao%20de%20Atividade%20Pratica%20de%20NoSQL%20-%20Werricsson%20Santos.pdf">clique aqui</a> </h5>