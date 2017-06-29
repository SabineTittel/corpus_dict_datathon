Problems
========

1. Sense hierarchy
------------------
There is no way to define a sense hierarchy in Lemon-OntoLex. There is a property `skos:narrower`, but it is not the best idea, because it means that the sense N is the main sense for Na is completely derived from it.

2. Variants and TEI

3. Register: it is not obvious, how to represent registers (technical, etc.) in the dictionary model. We introduced a new property for this
	
4. Problems with a format: there were some problems with LaTeX format
5. RDFa decisions: we had to create an empty span in order to include links into the TEI-XML corpus. This is not as bad as it could be :)

6. Lemon — no properties for linking from a corpus to a dictionary: we used `rdfs:seeAlso`, but this is obviously too generic to model this. There is also rdfs:isDefinedBy, but it is not exactly what we need. Do we need to create a new property for this?
