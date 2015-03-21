This directory contains the scripts which make the configuration policy
document out of the individual Puppet input files and any documentation
manually written in LaTeX.

Alongside this unified-policy-document directory should be the manifests,
modules (or modules-*), and latex-documentation directories.

You will need:

* Python 2.6 or later (but not yet 3.x)
* TeX and LaTeX. Under Windows, use MiKTeX or ProTeXt. Under Linux, use
  TeXLive or the older teTeX.
* the cyber_ and cybercic_ LaTeX packages installed
* Shaney_

If everything is in order, run make.py or make.pyw. To clean, run
clean.py. Under Windows, you can double-click the files to run
them. Under Linux, you'll likely use the command line. Examples::

    python make.py
    python clean.py

.. _cyber: https://github.com/jaredjennings/latex-cyber
.. _cybercic: https://github.com/jaredjennings/latex-cybercic
.. _Shaney: https://github.com/jaredjennings/shaney
