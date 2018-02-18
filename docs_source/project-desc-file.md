# Header

```xml
<header>
  <authorName>Nicolas de Dinkelsbuhl</authorName>
  <commentaryName>Nicolas de Dinkelsbuhl Lectura Mellicensis</commentaryName>
  <commentaryid>dinkelsbuhllectura</commentaryid>
  <commentaryslug>nddm</commentaryslug>
  <authorUri>http://scta.info/resource/NicolasDeDinkelsbuhl</authorUri>
  <parentUri>http://scta.info/resource/dinkelsbuhllectura</parentUri>
	<parentWorkGroup>http://scta.info/resource/sententia</parentWorkGroup>
  <textfilesdir>/Users/jcwitt/Projects/scta/scta-texts/dinkelsbuhllectura/</textfilesdir>
  <webbase>null</webbase>
  <questionListSource>Monica Article</questionListSource>
  <questionListOriginalEditor>Monica Brinzei</questionListOriginalEditor>
  <questionListEncoder>Jeffrey C. Witt</questionListEncoder>
	<sponsors>
		<sponsor id="erc-thesis">
			<name>ERC-THESIS project n° 313339</name>
			<logo>https://www.mathi.uni-heidelberg.de/~venjakob/ERC_transparent.png</logo>
			<link>http://www.thesis-project.ro/</link>
			</sponsor>
		<sponsor id="irht">
			<name>IRHT</name>
			<logo>http://cald.irht.cnrs.fr/images/logo_irht_cnrs.png</logo>
			<link>http://www.irht.cnrs.fr/</link>
		</sponsor>
	</sponsors>
  <hasWitnesses>
    <witness id="T">
      <slug>bnf</slug> <!--need to change this when manifest changes -->
      <title>TM 536</title>
      <initial>T</initial>
    </witness>
    <witness id="B">
      <slug>clm2940</slug>
      <title>BSB Clm 2940</title>
    </witness>
    <witness id="Ba">
      <slug>clm8358</slug>
      <title>BSB Clm 8358</title>
    </witness>
  </hasWitnesses>
</header>
```


# Body

```xml
<div id="body">
  <div id="nddm-librum4" class="toplevel" type="librum" subtype="librum4">
    <head>Liber IV</head>
    <div id="nddm-l4d1" type="distinctio" subtype="librum4-distinctio1">
      <head>Liber IV, Distinctio 1</head>
      <div id="nddm-l4d1p1">
        <head>Liber IV, Distinctio 1, Pars 1</head>
      </div>
    </div>
  </div>
</div>
```

## Div

## Item

```xml
<item type="quaestio">
  <fileName filestem="nddm-l4d1p1q1"/>
  <title>Liber IV, d. 1, p. 1, q. 1</title>
  <questionTitle>Utrum in quolibet hominum statu fuerint aliqua sacramenta.</questionTitle>
  <hasWitnesses>
    <witness ref="#T">
      <folio>1r</folio>
      <folio>1v</folio>
      <folio>2r</folio>
      <folio>2v</folio>
      <folio>3r</folio>
      <folio>3v</folio>
      <folio>4r</folio>
      <folio>4v</folio>
      <folio>5r</folio> <!-- col. a -->
    </witness>
  </hasWitnesses>
</item>

```
