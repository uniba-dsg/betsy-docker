class Engine
	attr_accessor :name, :type, :real_name

	def initialize(name, type)
		@real_name = name
		@name = @real_name.gsub("__", "")		
		@type = type
	end
end

engines = [
	Engine.new("ode__1_3_6", :bpel),
	Engine.new("ode__1_3_5", :bpel),
	Engine.new("bpelg__5_3", :bpel),
	Engine.new("activiti__5_15_1", :bpmn),
	Engine.new("activiti__5_16_3", :bpmn),
	Engine.new("activiti__5_17_0", :bpmn),
	Engine.new("activiti__5_18_0", :bpmn),
	Engine.new("jbpm__6_0_1", :bpmn),
	Engine.new("jbpm__6_1_0", :bpmn),
	Engine.new("jbpm__6_2_0", :bpmn),
	Engine.new("jbpm__6_3_0", :bpmn),
	Engine.new("camunda__7_0_0", :bpmn),
	Engine.new("camunda__7_1_0", :bpmn),
	Engine.new("camunda__7_2_0", :bpmn),
	Engine.new("camunda__7_3_0", :bpmn)
]

def dockerfile(engine)
"""# This is a Dockerfile to create an image with betsy and the engine #{engine.name} installed.

# Version 1.0

FROM betsy

MAINTAINER Simon Harrer (simon.harrer@uni-bamberg.de)

# install #{engine.real_name}
RUN ./betsy engine #{engine.real_name} install
"""
end

def setup_shell_script(engine)
"""./setup

docker build --tag='betsy-#{engine.name}' --file=image/Dockerfile_#{engine.name} image
"""
end

def start_shell_script(engine)
"""#!/bin/bash
source common.sh

./setup-#{engine.name}

docker run betsy-#{engine.name} sh betsy #{engine.type} --keep-engine-running --use-installed-engine #{engine.real_name} \"$*\"

params=`echo \"$*\" | tr ' =' '_'`
folder=results/betsy-bpel-#{engine.name}-$params-`date +%s`
container=`docker ps -alq`

extractLogs \"$container\" \"$folder\"
# open \"$folder/test/reports/results.html\"
"""
end

def setup_all_script(engines)
"""#!/bin/bash
#{engines.map { |e| "./betsy-#{e.name}" }.join("\n")}
"""
end


engines.each do |engine|

	File.write("image/Dockerfile_#{engine.name}", dockerfile(engine))
	File.write("setup-#{engine.name}", setup_shell_script(engine))
	File.write("betsy-#{engine.name}", start_shell_script(engine))

end
File.write("setup-all", setup_all_script(engines))
