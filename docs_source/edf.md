# Introduction

The *Expression Description File* (EDF) presents an editorial interpretation of a text. 

This means that for example a title or the structure reflected in the file should not reflect the structure or content of any one particular manuscript witness.

References to existing entities in the SCTA system is done with the URL of the given resource. So a reference to Adam Wodeham would be http://scta.info/resource/Wodeham. In the EDF files the namespace `sctar` (*SCTA Resource*) will preface any such resource ids.

The EDF files are used for constructing entities in the system. When references are made to already existing entities, the `sctar:` namespace is used. But in the case of ids of expressions or structural divs, the id does not refer to something existing before the EDF file is ingested, but is rather created during ingestion, and will therefore occur without the namespace.

# EDF Root

EDF file must contain and EDF root, which contains precisely two children `<header>` and `<body>`.

`edf` **MUST** declare the included namespaces.

```xml
<edf 
  xmlns:dc="https://dublincore.org/2012/06/14/dcelements#"
  xmlns:sctar="https://scta.info/resource/">
  <header/>
  <body/>
</edf>
```

# Header

## Description
A header contains a `creationStmt`.

## Example

```xml
<header>
  <creationStmt/>
</header>

```

# Creation Stmt

## Description 

The `creationStmt` should contain information about the file itself (e.g. when
it was created, what schema it is validated against, etc).

## Example

```xml
<creationStmt>
  <schema 
      name="edf" 
      version="1.0.0"
      url="https://raw.githubusercontent.com/scta/edf-schema/1.0.0/src/edf.rng"/>
</creationStmt>
```

# Body

## Description

Body is the bulk of the file which records the text hierarchy.

## Examples

```xml
<body>
  <!-- contains nested divs -->
</body>
```

# Top Level Div

## Description
The Top Level Div is the highest level of the expression, also called the top level expression.
Because it is the top level it is allowed certain properties not allowed to child divs.
For example only the top level div can contain a parentWork or parentWorkGroup field,
because only top level expressions can be children of a work or workGroup.

## Rules

- **MUST** contain `@id` (resource id).
- **MAY** contain `@type`. It **MUST** contain SCTA supported values for expression types.
- **MUST** contain a `titleStmt` as a child node.
- `titleStmt` **MUST** contain at least one of `structureTitle`, `alternativeTitle`, `descriptiveTitle`, and `questionTitle` according to the description in the section below.
- **MUST** contain at least one `contributor` element (resource id).
- `contributor` **SHOULD** contain `@role`. It **MUST** contain SCTA supported values for contributor roles.
- **MAY** contain `dc:description`. It cannot contain any child elements, and should be no more than 250 words.
- **MUST** contain `work`, which contains a unique id to a work.
- `work` **MAY** have `@isCanonical`.
- `work` **MUST** have `@parentWorkGroup` (resource id) when it has `@isCanonical`.
- `dc:date` **MUST** contain a [EDTF](https://www.loc.gov/standards/datetime/pre-submission.html#level1) compliant date.


**NOTES** 
- What to do when creating EDF with unregistered resources?
- Possible values for `@parentWorkGroup`? 
- How to determine whether there is already a work id for an EDF?
- Possible `div/@types` values?
- Paragraph on where we use short-ids, and where to find them...

## Example

```xml
<div id="wodehamordinatio" type="sctar:ordinatio">
  <titleStmt>
    <structureTitle>Commentarius sententiarum</structureTitle>
    <alternativeTitle>Ordinatio</alternativeTitle>
    <descriptiveTitle />
    <questionTitle />
  </titleStmt>
  <dc:description>Description of the expression.</dc:description>
  <contributor role="author">sctar:Wodeham</contributor>
  <work isCanonical="true" parentWorkGroup="sctar:sententia">sctar:w-wodehamordinatio</work>
  <dc:date>133u</dc:date>
  <manifestations>
    <!-- top level manifestation block -->
  </manifestations>
  <attribution>
    <!-- see attribution block -->
  </attribution>
  <!-- lower level divs and items to be added here -->
</div>
```

## Work field
The field `work` reflects the FRBR concept of a Work. This field indicates which work the expression is an expression of, as there can be different expressions of a single work. The `@isCanonical` will indicate whether the expression described by the EDF is considered the "canonical" or "default" expression of the work in different contexts (e.g. search results). The value of the `work` element indicates the short id of the Work. The content of the field **MUST** be unique. In order to ensure the uniqueness of the id, it is recommended as best practice to use the id of the canonical expression prefixed by "w-", e.g. "w-wodehamordinatio".

The `work` does two things, as it both creates the entity of the work in the graph and indicate where in a hierarchy that belongs to by the `@parentWorkGroup` id. 

`work`: If there is already another expression description file that is accepted as the canonical expression description type (`@isCanonical='true'`), the `@parentWorkGroup` is not required, as it is already indicated on the canonical EDF.


# titleStmt

## Description 
The `titleStmt` contains a set of elements indicating different types of titles on the section of text.

The order of the elements determines the default title by the first child node. If the `structureTitle` is empty, the following field will give the title. The structure of the items **MUST** be the following:

```xml
<titleStmt>
    <structureTitle />
    <alternativeTitle />
    <descriptiveTitle />
    <questionTitle />
</titleStmt>
```

Use of different title fields: 
- `structureTitle` indicates a place in the structure of the text, such as "Article 3". 
- `alternativeTitle` indicates an alternative name of a given question. There can be 0 to many alternative titles listed
- `descriptiveTitle` indicates a descriptive statement on the subject of the text. 
- `questionTitle` indicates a name of a given question.


## Rules

- `titleStmt` **MUST** contain at least one of `structureTitle`, `alternativeTitle`, `descriptiveTitle`, and `questionTitle` according to the description in the section below.
- `titleStmt` **MAY ONLY** contain 0 or 1 instance of `structureTitle`, `alternativeTitle`, `descriptiveTitle`.
- `titleStmt` **MAY** contain any number of `alternativeTitle` elements.
- `structureTitle` **MAY** containt `@n` and `@label` to indicate in a machine-readable the position in the structure of the work.


# Top Level Manifestation Blocks

## Description
Top level manifestation blocks record all existing manifestations (manuscripts, printed books, born digital manifestations) for an expression. Information provided is also used as a reference point for item level manifestation recognition, reducing redundancy.

Top Level Manifestation Blocks and Item Level Manifestation Blocks work in tandem to identify which sections of the hierarchy are represented in which manifestations.

For example, we need not redundantly identify manifestations for every level of the hierarchy. Rather we can record that a manifestation exists for a given item. This information can then "bubble up", meaning, at any level of the hierarchy we can deduce if there is existing manifestation of that level by seeing if there are any manifestations for item children with that div. If that is that case, then we can conclude this section has that manifestation.

This need arises often in cases where a manuscript X only contains book two of a four book sequence. In this case, all the items within the book two ranges, will identify a presence in manuscript X through a reference to the top level manifestation block. From there it can be concluded that Book 2 has a manifestation in manuscript X, but we can also conclude that manuscript X does not contain manifestations of books 1, 3 or 4.

See Item Level Manifestation Blocks Below.

There is no title given explicitly for each manifestation, as that will be pulled from the codex manifestation title in the Codex Description File referenced by the `codexId`.

## Rules
- **MUST** contain at least one `manifestation`.
- `manifestation` **MUST** contain a `codexId` (resource short id).
- `manifestation` **MAY** contain a `dc:description`.

## Example

```xml
<manifestations>
  <manifestation siglum="T">
    <codexId>sctar:bnf1039</codexId>
    <dc:description>Short description of the codex manifestation.</dc:description>
  </manifestation>
  <manifestation siglum="B">
    <codexId>sctar:clm2940</codexId>
  </manifestation>
  <manifestation siglum="Ba">
    <codexId>sctar:clm8358</codexId>
  </manifestation>
</manifestations>
```

# Intermediate Level Divs

## Description

A `div` at any level below the top-level `div` reflect the structure of the text.

## Rules

- **MAY** contain `titleStmt` respecting its possible elements and rules.
- **MAY** contain `attribution` respecting its possible elements and rules.
- **MAY** contain `dc:description`.
- **MAY NOT** contain `manifestations`. 

## Example

```xml
<div id="ow-l1" type="sctar:liber">
  <titleStmt>
    <structureTitle n="1" label="liber">Liber 1</structureTitle>
  </titleStmt>
  <dc:description>
    Here is a short description of liber 1 of the text.
  </dc:description>
  <div id="ow-l1d1" type="sctar:liber1-distinctio1">
    <titleStmt>
      <structureTitle n="1" label="distinctio">Liber 1</structureTitle>
      <questionTitle>Uti et frui</questionTitle>
    </titleStmt>
    <div id="ow-l1d1p1">
      <titleStmt>
        <structureTitle n="1" label="pars">Pars 1</structureTitle>
      </titleStmt>
      <!-- contains items as lowest level -->
    </div>
  </div>
</div>
```


# Item

## Description 

Item blocks are the lowest level text division that the EDF records. 

These division correspond to directory structure and file divisions.
Transcriptions for a given text need to be divided into directories with the identical name as the `item@id`.

Files within the item directory by default are named with the `item@id` plus a prefix. But this behavior can be overwritten in the `transcriptions.xml` file.

## Rules
- **MUST** have `@id`.
- **MAY** have `@type`.
- **MAY** contain `titleStmt` respecting its possible elements and rules.
- **MAY** contain `attribution` respecting its possible elements and rules.
- **MAY** contain `dc:description`.

Possible values in item types??

## Example

```xml
<item id='nddm-l4d1p1q1' type="sctar:quaestio">
  <titleStmt>
    <structureTitle n="1" label="quaestio">Quaestio 1</structureTitle>structureTitle>
    <questionTitle>
      Utrum in quolibet hominum statu fuerint aliqua sacramenta.
    </questionTitle>
  </titleStmt>
  <dc:description>Short description</dc:description>
  <manifestations>
    <manifestation ref="#T">
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
  </manifestations>
</item>

```

## Item Level Manifestation Blocks

### Description 

Item level manifestation blocks note that that this item can be found in a given manifestation through a reference to a top level manifestation block.

### Rules
- **MUST** contain `@ref`.
- **MUST** contain one or more `folio` elements.
- `folio` **MAY** have `@c`.

```xml
<manifestation ref="#T">
  <folio c="b">1r</folio>
  <folio>1v</folio>
  <folio>2r</folio>
  <folio>2v</folio>
  <folio>3r</folio>
  <folio>3v</folio>
  <folio>4r</folio>
  <folio>4v</folio>
  <folio c="a">5r</folio> <!-- col. a -->
</manifestation>
```

# Attribution Block

## Description

Any level of the hierarchy could take an attribution block and will apply to all children blocks.
In most cases, only the top level block would take this. But when there are multiple parties
responsible for different ranges with the hierarchy, lower level attribution blocks can be added.

Responsibility here is intended to apply to the maintenance of the question list and structured hierarchy of the text, not to the transcription or edition of the text. This attributions is gleaned from the transcription TEI file

## Rules
- **MAY** contain `listEncoder`.
- **MAY** contain `listOriginal`.
- **MAY** contain `listSource`.
- **MAY** contain `sponsors`.
- `sponsors` **MUST** contain at least one `sponsor`.
- `sponsor` **MUST** contain `name`.
- `sponsor` **MAY** contain `logo` as a URL to an image file.
- `sponsor` **MAY** contain `link` as a URL a supporting entity.

## Example

```xml
<attribution>
  <listSource>Monica Article</listSource>
  <listOriginalEditor>Monica Brinzei</listOriginalEditor>
  <listEncoder>Jeffrey C. Witt</listEncoder>
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

Or, lower down "liber1-distinctio1", "liber1-distinctio2", "liber1-prologus" etc.

In the case of the prologue, there is no need to classify this as both a "prologus" and a "liber1-prologus" because elsewhere "liber1-prologus" would have already been classified as a type of prologue.

If a top level expression is categorized as de anima commentary, different expression types become available, such as:
"da-liber1", "da-liber2", "da-liber3", etc.

Additional optional properties could become available based on a expressionTypes.

So for example if an sentences commentary is categorized as an "abbreviatio", and `<abbreviatedBy>` property could become available.

Such rules can be enforced by a schematron rules, but will require a detailed list of expression types.
