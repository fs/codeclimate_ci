require 'thor'

module CodeclimateCi
  class CLI < Thor
    method_option :codeclimate_api_token, required: true
    method_option :repo_id, required: true
    method_option :branch_name, required: true

    desc('check', 'Check code quality with CodeClimate')

    def check
      CodeclimateCi.configuration.load_from_options(options)

      if CodeclimateCi::CompareGpa.new(codeclimate_api_token, repo_id).worse?(branch_name)
        puts 'Code in your branch became worse'
        exit(1)
      else
        puts 'Code in your branch is good. Go on...'
      end
    end

    default_task :check

    private

    def codeclimate_api_token
      CodeclimateCi.configuration.codeclimate_api_token
    end

    def repo_id
      CodeclimateCi.configuration.repo_id
    end

    def branch_name
      CodeclimateCi.configuration.branch_name
    end
  end
end