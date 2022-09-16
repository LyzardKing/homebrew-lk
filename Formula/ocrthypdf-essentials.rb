class OcrthypdfEssentials < Formula
  include Language::Python::Virtualenv
  desc "Make your PDF files text-searchable (A GUI for OCRmyPDF)"
  homepage "https://github.com/digidigital/OCRthyPDF-Essentials"
  url "https://github.com/digidigital/OCRthyPDF-Essentials/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "93547924e92407d1b63a8a3ebed25cedf075db5587ee2dfeddd92b678facc5ae"
  license "AGPL-3.0-only"
  revision 1

  depends_on "libxml2"
  depends_on "ocrmypdf"
  depends_on "pillow"
  depends_on "python-tk@3.9"
  depends_on "python@3.9"
  depends_on "qpdf"

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/70/bb/7a2c7b4f8f434aa1ee801704bf08f1e53d7b5feba3d5313ab17003477808/lxml-4.9.1.tar.gz"
    sha256 "fe749b052bb7233fe5d072fcb549221a8cb1a16725c47c37e42b0b9cb3ff2c3f"
  end

  resource "pikepdf" do
    url "https://files.pythonhosted.org/packages/c7/b2/f2fb8157a75248d6995576ea72514da185d15e6fe945b326ee4c548ea24e/pikepdf-6.0.1.tar.gz"
    sha256 "519a017282780ad2d547cd848407ab03b2cb12ee467b71e51f53ca7f4f3146ea"
  end

  resource "PySimpleGUI" do
    url "https://files.pythonhosted.org/packages/8d/3b/4906c9b23192d6b0c78c640223cb3e4365be3ec020ac4c00d72d73e72ff2/PySimpleGUI-4.60.3.tar.gz"
    sha256 "75ec46694dc975c0e46be8c57a774e038433b53095821d67be3b221aca3fd68d"
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
