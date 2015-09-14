class Engine
	attr_accessor :name, :type

	def initialize(name, type)
		@name = name
		@type = type
	end
end

engines = [
	Engine.new("ode", :bpel),
	Engine.new("bpelg", :bpel),
	Engine.new("orchestra", :bpel),
	Engine.new("active-bpel", :bpel),
	Engine.new("activiti", :bpmn),
	Engine.new("camunda720", :bpmn),
	Engine.new("camunda730", :bpmn)
]

def dockerfile(engine)
"""# This is a Dockerfile to create an image with betsy and the engine #{engine.name} installed.

# Version 1.0

FROM betsy

MAINTAINER Simon Harrer (simon.harrer@uni-bamberg.de)

# install #{engine.name}
RUN ./betsy engine #{engine.name} install
"""
end

def setup_shell_script(engine)
"""./setup-betsy

docker build --tag='betsy-#{engine.name}' --file=image/Dockerfile_#{engine.name} image
"""
end

def start_shell_script(engine)
"""#!/bin/bash
source common.sh

./setup-#{engine.name}

docker run betsy-#{engine.name} sh betsy #{engine.type} --use-installed-engine #{engine.name} \"$*\"

params=`echo \"$*\" | tr ' =' '_'`
folder=results/betsy-bpel-#{engine.name}-$params-`date +%s`
container=`docker ps -alq`

extractLogs \"$container\" \"$folder\"
open \"$folder/test/reports/results.html\"
"""
end


engines.each do |engine|

	File.write("image/Dockerfile_#{engine.name}", dockerfile(engine))
	File.write("setup-#{engine.name}", setup_shell_script(engine))
	File.write("betsy-#{engine.name}", start_shell_script(engine))

end
