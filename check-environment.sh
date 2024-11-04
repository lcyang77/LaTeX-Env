{
    "latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-shell-escape",
                "%DOC%"
            ]
        },
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-xelatex",
                "-shell-escape",
                "-outdir=%OUTDIR%",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "XeLaTeX",
            "tools": [
                "xelatex"
            ]
        },
        {
            "name": "XeLaTeX ➞ BibTeX ➞ XeLaTeX × 2",
            "tools": [
                "xelatex",
                "bibtex",
                "xelatex",
                "xelatex"
            ]
        },
        {
            "name": "latexmk",
            "tools": [
                "latexmk"
            ]
        }
    ],
    "latex-workshop.latex.autoBuild.run": "onSave",
    "latex-workshop.latex.autoClean.run": "onBuilt",
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux", "*.bbl", "*.blg", "*.idx", "*.ind",
        "*.lof", "*.lot", "*.out", "*.toc", "*.acn",
        "*.acr", "*.alg", "*.glg", "*.glo", "*.gls",
        "*.ist", "*.fls", "*.log", "*.fdb_latexmk"
    ],
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.intellisense.package.enabled": true,
    "latex-workshop.message.error.show": true,
    "latex-workshop.message.warning.show": true,
    "latex-workshop.latex.recipe.default": "first",
    "latex-workshop.view.pdf.zoom": "page-width",
    "latex-workshop.latex.clean.subfolder.enabled": true,
    "latex-workshop.synctex.afterBuild.enabled": true,
    "latex-workshop.latex.rootFile.useSubFile": true,
    "latex-workshop.latex.magic.args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-shell-escape",
        "%DOC%"
    ],
    "editor.formatOnSave": true,
    "files.associations": {
        "*.tex": "latex"
    }
}
