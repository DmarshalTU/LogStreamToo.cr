require "option_parser"

# Stream logs from a Kubernetes pod to a file and open it in the specified editor.
#
# This tool allows you to stream logs from a specific Kubernetes pod
# and save them to a file. It also opens the file in the specified editor
# with autoread enabled for real-time log monitoring.
module LogStreamTool
  extend self

  # Stream logs from the specified pod to a file.
  #
  # @param pod_name [String] The name of the Kubernetes pod.
  # @param namespace [String] The namespace of the pod.
  # @param file_path [String] The path to the log file.
  # Function to continuously stream logs from a specific pod
  def stream_pod_logs(pod_name : String, namespace : String, file_path : String)
    # Check if kubectl exists in the system's PATH
    if system("which kubectl >/dev/null 2>&1")
      command = "kubectl logs -f #{pod_name} -n #{namespace} > #{file_path}"
      system(command)
    else
      puts "kubectl is not installed or not found in the system's PATH."
      puts "Please install kubectl and ensure it is in your PATH."
    end
  end


  # Open the log file in the specified editor.
  #
  # @param editor [String] The name of the editor (vim, neovim, code, etc.).
  # @param file_path [String] The path to the log file.
  def open_in_editor(editor : String, file_path : String)
    # Check if the editor is available on the system
    if system("which #{editor} >/dev/null")
      system("#{editor} #{file_path}")
    else
      puts "#{editor} is not installed on your system."
      puts "Consider using of the default editors: vim."
    end
  end


  # Parse command-line options and execute the log streaming and editor logic.
  def run(args : Array(String))
    options = {
      "namespace" => "default",
      "pod_name" => "nginx",
      "editor" => "vim"
    }

    option_parser = OptionParser.new do |parser|
      parser.banner = "LogStreamTool - Stream Kubernetes pod logs and open in an editor, by Denis Tu."
      parser.separator ""
      parser.separator "Usage: logstream [options]"

      parser.on("--namespace NAME", "Specify the namespace") do |namespace|
        options["namespace"] = namespace
      end

      parser.on("--pod-name NAME", "Specify the pod name") do |pod_name|
        options["pod_name"] = pod_name
      end

      parser.on("--editor NAME", "Specify the editor (vim, nvim, code)") do |editor|
        options["editor"] = editor
      end

      parser.separator ""
      parser.separator "Examples:"
      parser.separator "  logstream --namespace default --pod-name nginx --editor vim"
      parser.separator "  logstream --namespace mynamespace --pod-name mypod --editor code"
      parser.separator ""

      parser.on("--help", "Show this help message") do
        puts parser
        exit(0)
      end
    end

    begin
      option_parser.parse(args)
    rescue ex
      puts ex.message
      puts option_parser
      exit(1)
    end

    log_file_path = "#{options["pod_name"]}.txt"

    begin
      spawn do
        stream_pod_logs(options["pod_name"], options["namespace"], log_file_path)
      end
      sleep(1)
      open_in_editor(options["editor"], log_file_path)
    rescue ex : Exception
      puts "Error: #{ex.message}"
    end
  end
end

LogStreamTool.run(ARGV)
