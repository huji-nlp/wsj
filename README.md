UCCA-Annotated Wall Street Journal Sentences
============================================
Version 1.0 (April 8, 2018)
-----------------------------

This bundle contains 130 sentences annotated according to the [foundational layer of UCCA](https://github.com/huji-nlp/ucca-corpora/tree/master/wiki#xml-format). 
100 sentences are from section 00 of the Wall Street Journal corpus, and 30 are from section 02.
The passages are given as xmls.
The total number of tokens in this corpus is 2818 (2273 from section 00 and 545 from section 02).

The dataset is a part of the UCCA project developed in the NLP lab of the Hebrew University 
by Omri Abend and Ari Rappoport. The users of this dataset are kindly requested to cite [the following publication](http://www.cs.huji.ac.il/~danielh/acl2018.pdf):

    @InProceedings{hershcovich2018multitask,
      author    = {Hershcovich, Daniel  and  Abend, Omri  and  Rappoport, Ari},
      title     = {Multitask Parsing Across Semantic Representations},
      booktitle = {Proc. of ACL},
      year      = {2018}
    }

Please refer to [our website](http://www.cs.huji.ac.il/~oabend/ucca.html) or email (oabend@cs.huji.ac.il)
for regular updates on the UCCA project and available resources.


Files included
--------------
1. The passages files in an XML format, under [`00/ucca`](00/ucca) and [`02/xml`](02/xml).
   file names in `00/ucca` are of the form `wsj_XXX.xml` where XXX 
   is the sentence ID. Please see [the UCCA resource webpage](http://www.cs.huji.ac.il/~oabend/ucca.html) for a software package for reading and using 
   these files.
2. [`00/wsj.txt`](00/wsj.txt) and [`02/wsj.txt`](02/wsj.txt): plain text of the annotated passages.

Licensing:
----------

The UCCA annotation is distributed under the 
"Attribution-ShareAlike 3.0 Unported" license (http://creativecommons.org/licenses/by-sa/3.0/).
