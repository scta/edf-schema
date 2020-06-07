<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="@id">
            <!-- Change the assert expression. -->
          <sch:let name="current-value" value="."></sch:let>
          <sch:assert test="count(//*[@id=$current-value]) = 1">The id values are not unique <sch:value-of select="count(//*[@id=$current-value])"/></sch:assert>
        </sch:rule>
      <sch:rule context="@filestem">
        <!-- Change the assert expression. -->
        <sch:let name="current-value" value="."></sch:let>
        <sch:assert test="count(//*[@filestem=$current-value]) = 1">The id values are not unique <sch:value-of select="count(//*[@filestem=$current-value])"/></sch:assert>
      </sch:rule>
    </sch:pattern>
</sch:schema>