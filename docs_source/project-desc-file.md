# Introduction

The 0.0.0 schema documents an ad hoc schema that has emerged over time.

The goal here is to document this practice and to make its intentions clear,
in order to facilitate the community development of a 1.0.0 schema that
serves the needs of the SCTA community

# Header

The header is meant to collect information about "the top level expression". There are several kinds of metadata about a top level expression that we need to collect. For clarity, we've tried to break this down into subcategories.

## Identification Metadata

This is information that generally corresponds to a typical library catalogue of scholastic works only interested in cataloguing the highest level of a text (e.g. Aquinas' Scriptum, Scotus' Ordinatio) etc. As such it needs to include author, title, date, and description information.

These properties currently include:

* `<authorName>`
  * a human readable label (should be unnecessary as this information should be retrieved from the Prosopography entry)
* `<authorUri>`
  * a machine readable unique id
* `<commentaryName>`
  * a human readable label
* `<commentaryid>`
  * a machine readable id, must be unique
* `<commentaryslug>`
  * a 2-5 letter id, used as a prefix below to guarantee uniqueness of ids in distributed files
* `<parentUri>`
  * unfortunate needless repetition of commentaryid
* `<description>`
  * description of the expression
* `<date>`
  * date expression was made
* `<parentWorkGroup>`
  * identify for a parentWorkGroup to which the expression belongs (e.g. sentencesCommentaries, deAnimaCommentaries, CanonLaw, etc).
  * consideration needed to be added about adding a `<parentWork>` designation

## Attribution Metadata

Secondly, it includes attribution information about the people and editors who are responsible for collecting this information as well as the text hierarchy and question list included below.

This information includes the following:

* `<questionListSource>`
* `<questionListOriginalEditor>`
* `<questionListEncoder>`
* `<sponsors>`


## Manifestation Metadata

Finally the manifestation information includes important ids and references that indicate existing manifestations of an expression.
Information here is used to link both to codices and is used below us to allow identify the existence of existing manifestations for an expression at granular levels. If one wanted to build a catalogue of every manuscript witness of an expression, a reference to each manuscript manifestation (a concept distinct from a codex manifestations) would need to be here. But manifestations can also include printed editions throughout history. They can also include born digital manifestations. Currently, the id "critical" is a reserved word for a default born digital manifestation.

Available fields include the following

* `hasWitnesses`
  * `witness`
    * `slug`
      * slug id used to link to a codex id, but it should be known that the witness and codex are not identical, when the RDF database is built, two different ids are created using this slug, `resource/<slug>` which represents the codex manifestation and `/resource/<toplevelexpression>/slug` representing the top_level_manifestation of this expression.
    * `title`
      * it is once again tempting to see this as identical to the title of the manuscript in which this manifestation occurs, but in fact this is the title of the manifestation within a codex manifestation. For example: if two expressions are manifested in a single codex, the will be only one codex and corresponding titles, but there will still be two manifestations, each with their own title or label.
    * `initial`
      * a utility id, unique only to this file, but not necessarily to other files. This initial is used below to link to this manifestation entry.

## Example
```xml
<listofFileNames>
    <header>
      <authorName>Nicolas de Dinkelsbuhl</authorName>
      <commentaryName>Nicolas de Dinkelsbuhl Lectura Mellicensis</commentaryName>
      <commentaryid>dinkelsbuhllectura</commentaryid>
      <commentaryslug>nddm</commentaryslug>
      <authorUri>http://scta.info/resource/NicolasDeDinkelsbuhl</authorUri>
      <parentUri>http://scta.info/resource/dinkelsbuhllectura</parentUri>
      <parentWorkGroup>http://scta.info/resource/sententia</parentWorkGroup>
      <textfilesdir>/Users/jcwitt/Projects/scta/scta-texts/dinkelsbuhllectura/</textfilesdir>
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
            <initial>B</initial>
          </witness>
          <witness id="Ba">
            <slug>clm8358</slug>
            <title>BSB Clm 8358</title>
            <initial>Ba</initial>
          </witness>
        </hasWitnesses>
    </header>
```


# Body

```xml
<div id="body">
    <!-- contains nested divs -->
</div>
```

## Div
```xml
<div id="nddm-librum4" class="toplevel" type="librum" subtype="librum4">
  <head>Liber IV</head>
  <div id="nddm-l4d1" type="distinctio" subtype="librum4-distinctio1">
    <head>Liber IV, Distinctio 1</head>
    <div id="nddm-l4d1p1">
      <head>Liber IV, Distinctio 1, Pars 1</head>
      <!-- contains items lowest level -->
    </div>
  </div>
</div>
```

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
