class OcrthypdfEssentials < Formula
  include Language::Python::Virtualenv
  desc "Make your PDF files text-searchable (A GUI for OCRmyPDF)"
  homepage "https://github.com/digidigital/OCRthyPDF-Essentials"
  url "https://github.com/digidigital/OCRthyPDF-Essentials/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "1bee3451fa89f0ebea6dcb1aa0160b454568bdd70aa7f2576f0323989e11f1b0"
  license "AGPL-3.0-only"
  revision 1

  depends_on "libxml2"
  depends_on "ocrmypdf"
  depends_on "pillow"
  depends_on "python-tk@3.9"
  depends_on "python@3.9"
  depends_on "qpdf"

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/e5/21/a2e4517e3d216f0051687eea3d3317557bde68736f038a3b105ac3809247/lxml-4.6.3.tar.gz"
    sha256 "39b78571b3b30645ac77b95f7c69d1bffc4cf8c3b157c435a34da72e78c82468"
  end

  resource "pikepdf" do
    url "https://files.pythonhosted.org/packages/a4/5c/6770b064dbe6402397cf87f07b92a252f73099705fcf980030404767bc62/pikepdf-3.0.0.tar.gz"
    sha256 "3c17937e230b22afa975e69130e89df2911dd1e2c7bbe200138684154e428843"
  end

  resource "PySimpleGUI" do
    url "https://files.pythonhosted.org/packages/e2/25/c0a25cae13989be372ccba48988fa1a46ff5cb9a08cc80d09f69df48e6db/PySimpleGUI-4.47.0.tar.gz"
    sha256 "36a7154ec018c8c56223f484ea9705548ab55dab7817dbe735ae51f4f5cd1652"
  end

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources
    cp_r ["code", "gui", "licenses"], prefix

    (bin/"ocrthypdf").write <<~EOS
      #! /bin/bash
      source #{prefix}/libexec/bin/activate
      python3 #{prefix}/code/OCRthyPDF.py
    EOS
  end
end
