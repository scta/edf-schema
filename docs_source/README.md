# EDF Docs

EDFs are an SCTA community standard to standardize the description of scholastic works as Expressions and to connect these expressions to their historical manifestations.

There are currently two specifications for EDFs, the 0.0.0 specifications which is currently in operation and the working draft of the 1.0.0 specifications.

* [0.0.0 (codename: Projectfiles)](project-desc-file.md)
* [1.0.0 (codename: red_leopard) (Status in Progress)](edf.md)

## Setting Up and Creating an EDF

With the aid of good XML editor, creating and EDF is fairly straightforward.

To create EDF that follows the 0.0.0 specification, add the following schema declaration at the top of your XML file, just below `<?xml version="1.0" encoding="UTF-8"?>`.

`<?xml-model href="https://raw.githubusercontent.com/scta/edf-schema/master/src/projectfile.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>`

To create EDF that follows the draft 1.0.0 specifications, add the following schema declaration at the top of your XML file, just below `<?xml version="1.0" encoding="UTF-8"?>`. Not that this is working draft and schema rules are subject to change.

Oxygen will begin prompting you for required fields. See the above specifications for EDF creation rules.

## Contributing an EDF

EDF files can be contributed to the SCTA community, by submitting a pull request the github `scta-projectiles` repository: [https://github.com/scta/scta-projectfiles](https://github.com/scta/scta-projectfiles)

To submit a pull request, "fork the above repository", add your newly created EDF, to the directory, and submit a pull request. The SCTA community will then review your request and merge it into the master repository.
