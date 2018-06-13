# EDF Root

EDF file must contain and EDF root, which contains precisely two children `<header>` and `<body>`

```xml
<edf>
  <header/>
  <body/>
</edf>
```

# Header

A header contains a `creationStmt`

```xml
<header>
  <creationStmt/>
</header>

```


## Creation Stmt

The `creationStmt` should contain information about the file itself (e.g. when
it was created, what schema it is validated against, etc)

```xml
<creationStmt>
  <date/>
  <schema name="edf" version="1.0.0"/>
</creationStmt>
```

# Body

Body is the bulk of the file which records the text hierarchy

```xml
<body>
  <!-- contains nested divs -->
</body>
```

## Top Level Div

The Top Level Div is the highest level of the expression, also called the top level expression.
Because it is the top level it is allowed certain properties not allowed to child divs.
For example only the top level div can contain a parentWork or parentWorkGroup field,
because only top level expressions can be children of a work or workGroup.

```xml
<div id="wodehamabbreviatio" type="abbreviatio">
  <!-- top level expression -->
  <!-- global optional fields could be applied -->
  <dc:title>Nicolas de Dinkelsbuhl Lectura Mellicensis</dc:title>
  <dc:description>Description</dc:description>
  <dc:creator>http://scta.info/resource/NicolasDeDinkelsbuhl</dc:creator>
  <!-- specific top level metadata could be applied -->
  <parentWorkGroup>http://scta.info/resource/sententia</parentWorkGroup>
  <!-- attribution or sponsorship could be applied for an entire range of texts,
       and overwritten by attributions lower in the hierarchy -->
  <manifestations>
    <!-- top level manifestation block -->
  </manifestations>
  <attribution>
    <!-- see attribution block -->
  </attribution>
  <!-- lower level divs and items to be added here -->
</div>
```

### Top Level Manifestation Blocks

Top level manifestation blocks record all existing manifestations (manuscripts, printed books, born digital manifestations) for an expression. Information provided is also used as a reference point for item level manifestation recognition, reducing redundancy.

Top Level Manifestation Blocks and Item Level Manifestation Blocks work in tandem to identify which sections of the hierarchy are represented in which manifestations.

For example, we need not redundantly identify manifestations for every level of the hierarchy. Rather we can record that a manifestation exists for a given item. This information can then "bubble up", meaning, at any level of the hierarchy we can deduce if there is existing manifestation of that level, but seeing if there are any manifestations for item children with that div. If there, then we can conclude this section has this manifestation.

This need arises often in cases where a manuscript X only contains book two of a four book sequence. In this case, all the items within the book two ranges, will identify a presence in manuscript X through a reference to the top level manifestation block. From there it can be concluded that Book 2 has a manifestation in manuscript X, but we can also conclude that manuscript X does not contain manifestations of books 1, 3 or 4.

See Item Level Manifestation Blocks Below

```xml
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

  </manifestations>
```

## Intermediate Level Divs

* dc:title
  * This should be a short title. It is recommended that aggregators build two kinds of titles, a short title and a full title. Short titles can be pulled directly from the `dc:title` field. Long titles, should be the concatenation of all ancestor short titles, with a delimiter, such as "Liber IV, Distinctio 1, Quaestio 1"


```xml
  <!-- begin hierarchy -->
  <div id="nddm-librum4" type="librum4">
    <dc:title>Liber IV</head>
    <questionTitle></questionTitle>
    <dc:description></description>
    <!-- attribution block can be added here, which will override parent attribution block for all of book 4 -->
    <!-- note that manifestations block is not allowed in intermediate div blocks -->
    <div id="nddm-l4d1" type="librum4-distinctio1">
      <dc:title>Distinctio 1</head>
      <questionTitle>uti et frui</questionTitle>
      <dc:description></description>
      <div id="nddm-l4d1p1">
        <dc:title>Pars 1</head>
        <questionTitle></questionTitle>
        <dc:description></description>
        <!-- contains items as lowest level -->

      </div>
    </div>
  </div>


```
## Item

Item blocks are the lowest level text division that the EDF records.
These division correspond to directory structure and file divisions.

Transcriptions for a given text need to be divided into directories with the identical name as the `item@id`.
Likewise, files within the item directory by default are named with the `item@id` plus a prefix. But this behavior can be overwritten in the `transcriptions.xml` file.

* dc:title
  * This should be a short title. It is recommended that aggregators build two kinds of titles, a short title and a full title. Short titles can be pulled directly from the `dc:title` field. Long titles, should be the concatenation of all ancestor short titles, with a delimiter, such as "Liber IV, Distinctio 1, Quaestio 1"

```xml

<item id='nddm-l4d1p1q1' type="quaestio">
  <dc:title>Quaestio 1</title>
  <dc:description></description>
  <questionTitle>Utrum in quolibet hominum statu fuerint aliqua sacramenta.</questionTitle>
  <manifestations>
  <!-- item level manifestation blocks go here -->
  </manifestations>
</item>

```
## Item Level Manifestation Blocks

Item level manifestation blocks note that that this item can be found in a given manifestation through a reference to a top level manifestation block.

```xml
<manifestations>
  <!-- item level manifestation blocks -->
  <!-- FYI this could get very long, as an item could be represented in more than a hundred manuscripts.
  This is not necessarily a problem just something to note.-->
  <manifestation ref="#T">
    <!-- technically folio information could be retrieved from transcriptions;
    but there are many cases where it is desirable to have this information,
    even when no transcriptions exist. Perhaps this information can be moved to a dummy file,
    standing in the place of a transcription file
    -->
    <folio c="b">1r</folio> <!-- is there a more efficient way to do this -->
    <folio>1v</folio>
    <folio>2r</folio>
    <folio>2v</folio>
    <folio>3r</folio>
    <folio>3v</folio>
    <folio>4r</folio>
    <folio>4v</folio>
    <folio c="a">5r</folio> <!-- col. a -->
  </manifestation>
</hasManifestations>
```

## Attribution Block

Any level of the hierarchy could take an attribution block and will apply to all children blocks.
In most cases, only the top level block would take this. But when there are multiple parties
responsible for different ranges with the hierarchy, lower level attribution blocks can be added.

Responsibility here is intended to apply to the maintenance of the question list and structured hierarchy of the text, not to the transcription or edition of the text. This attributions is gleaned from the transcription TEI file

```xml
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
```

## Expression Types

the `@type` attribute is used to classify expressions and expression parts.

The list of available values are maintained by the SCTA community. Values are hierarchical and flow down from works groups, works, etc.

Thus, if a expression is listed as belonging to a particular workGroup, for example "Sentences commentaries",
and limited list of expressionType values becomes available, for example, "ordinatio", "reportatio", "abbreviatio".

Or, lower down librum1-distinctio1, librum1-distinctio2, "librum1-prologus" etc.

In the case of the prologue, there is no need to classify this as both a "prologus" and a "librum1-prologus" because elsewhere "librum1-prologus" would have already been classified as a type of prologue.

If a top level expression is categorized as de anima commentary, different expression types become available, such as:
da-liber1, da-liber2, da-liber3, etc.

Additional optional properties could become available based on a expressionTypes.

So for example if an sentences commentary is categorized as an "abbreviatio", and `<abbreviatedBy>` property could become available.

Such rules can be enforced by a schematron rules, but will require a detailed list of expression types.
