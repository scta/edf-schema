# Header

```xml
<header>
  <identification>
    <authorUri>http://scta.info/resource/NicolasDeDinkelsbuhl</authorUri>
    <commentaryslug>nddm</commentaryslug> <!-- review -->
    <parentWorkGroup>http://scta.info/resource/sententia</parentWorkGroup>
  </identification>
  <attribution>
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
  </attribution>
  <manifestations>
    <manifestation id="T">
      <slug>bnf</slug> <!--need to change this when manifest changes -->
      <dc:title>TM 536<dc:title> <!-- this is the title of the manifestation, not the CODEX! -->
      <!-- dc:description could be a global attribute allowed on every resource -->
    </manifestation>
    <manifestation id="B">
      <slug>clm2940</slug>
      <dc:title>BSB Clm 2940</dc:title>
      <!-- dc:description could be a global attribute allowed on every resource -->
    </manifestation>
    <manifestation id="Ba">
      <slug>clm8358</slug>
      <dc:title>BSB Clm 8358</dc:title>
      <!-- dc:description could be a global attribute allowed on every resource -->
    </manifestation>
  </hasManifestations>
</header>
```

# Body

```xml
<body>
  <!-- contains nested divs -->
</body>
```
## Div

```xml
<div id="dinkelsbuhllectura" type="commentary" subtype="abbreviatio"> <!-- top level expression -->
  <!-- global optional fields could be applied -->
  <dc:title>Nicolas de Dinkelsbuhl Lectura Mellicensis</dc:title>
  <dc:description>Description</dc:title>
  <!-- begin hierarchy -->
  <div id="nddm-librum4" type="librum" subtype="librum4">
    <shortTitle>Liber IV</shortTitle>
    <dc:title>Liber IV</head>
    <questionTitle></questionTitle>
    <dc:description></description>
    <div id="nddm-l4d1" type="distinctio" subtype="librum4-distinctio1">
      <shortTitle>Distinctio 1</shortTitle>
      <dc:title>Liber IV, Distinctio 1</head>
      <questionTitle></questionTitle>
      <dc:description></description>
      <div id="nddm-l4d1p1">
        <shortTitle>Pars 1</shortTitle>
        <dc:title>Liber IV, Distinctio 1, Pars 1</head>
        <questionTitle></questionTitle>
        <dc:description></description>
        <!-- contains items as lowest level -->

      </div>
    </div>
  </div>
</div>

```
## Item

```xml

<item id='nddm-l4d1p1q1' type="quaestio">
  <shortTitle>Quaestio 1</shortTitle>
  <dc:title>Liber IV, d. 1, p. 1, q. 1</title>
  <dc:description></description>
  <questionTitle>Utrum in quolibet hominum statu fuerint aliqua sacramenta.</questionTitle>
  <hasManifestations>
    <!-- this could get very long -->
    <manifestation ref="#T">
      <!-- technically folio information could be retrieved from transcriptions;
      but there are many cases where it is desirable to have this information,
      even when no transcriptions exist. Perhaps this information can be moved to a dummy file,
      standing in the place of a transcription file

      -->
      <folio>1r</folio> <!-- is there a more efficient way to do this -->
      <folio>1v</folio>
      <folio>2r</folio>
      <folio>2v</folio>
      <folio>3r</folio>
      <folio>3v</folio>
      <folio>4r</folio>
      <folio>4v</folio>
      <folio>5r</folio> <!-- col. a -->
    </manifestation>
  </hasManifestations>
</item>

```
