build:
	docker build . -t cgspeck/joplin-ffs

shell:
	docker run -it --rm --env-file ./env --entrypoint /bin/bash cgspeck/joplin-ffs
