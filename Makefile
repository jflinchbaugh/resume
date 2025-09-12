all: resume.pdf resume.docx resume.txt resume.ps

resume.pdf: resume.dvi
	dvipdf resume.dvi
	exiftool -overwrite_original -Title="John M Flinchbaugh" resume.pdf

resume.txt: resume.tex
	pandoc -t plain resume.tex > resume.txt
	sed 's!john@.*!john@hjsoft.com\ngithub.com/jflinchbaugh\nLancaster, PA, USA!' -i resume.txt

resume.ps: resume.dvi
	dvips resume.dvi

resume.dvi: resume.tex
	latex resume.tex

resume.docx: resume.tex
	pandoc -o resume.docx resume.tex

publish: all
	scp resume.txt resume.pdf app01:public_html/

clean:
	rm -f *.pdf *.dvi *.log *.ps *.txt *.bak *.docx *.aux
