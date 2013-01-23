build:
	f2py -m sumcalcs -c sumcalcs.f90 --f90flags=-ftree-vectorize

frames.h5: flatflakec.py
	python $<

animation.gif: frames.h5
	python render.py $< "results/frame%04i.png"
	convert results/frame*.png $@

clean:
	-rm *.o *.so

.phony: build