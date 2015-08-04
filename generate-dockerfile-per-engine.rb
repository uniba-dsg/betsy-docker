engines = ["ode", "bpel-g", "orchestra"]

def dockerfile(engine) 
"""# This is a Dockerfile to create an image with betsy and the engine #{engine} installed.

# Version 1.0

FROM betsy

MAINTAINER Simon Harrer (simon.harrer@uni-bamberg.de)

# install #{engine}
RUN ./betsy engine #{engine} install
"""
end

def setup_shell_script(engine)
"""./setup-betsy

docker build --tag='betsy-#{engine}' --file=image/Dockerfile_#{engine} image 
"""
end

def start_shell_script(engine)
"""#!/bin/bash
source common.sh

./setup-#{engine}

docker run betsy-#{engine} sh betsy bpel #{engine} --use-installed-engine \"$*\"

params=`echo \"$*\" | tr ' =' '_'`
folder=results/betsy-bpel-#{engine}-$params-`date +%s`
container=`docker ps -alq`

extractLogs \"$container\" \"$folder\"
open \"$folder/test/reports/results.html\"
"""
end


engines.each do |engine|

	File.write("image/Dockerfile_#{engine}", dockerfile(engine))
	File.write("setup-#{engine}", setup_shell_script(engine))
	File.write("betsy-#{engine}", start_shell_script(engine))

end