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
  depends_on "python-lxml"
  depends_on "python-tk@3.9"
  depends_on "python@3.9"

  depends_on "qpdf"

  resource "PySimpleGUI" do
    url "https://files.pythonhosted.org/packages/8d/3b/4906c9b23192d6b0c78c640223cb3e4365be3ec020ac4c00d72d73e72ff2/PySimpleGUI-4.60.5.tar.gz"
    sha256 "31014d1cc5eef1373d7e93564ff2604662645cc774a939b1f01aa253e7f9d78b"
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
