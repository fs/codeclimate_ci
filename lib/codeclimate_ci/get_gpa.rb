module CodeclimateCi
  class GetGpa
    def initialize(codeclimate_api, branch)
      @codeclimate_api, @branch = codeclimate_api, branch
    end

    def analyzed?
      branch_info.include?['last_snapshot']
    end

    def gpa
      branch_info['last_snapshot']['gpa'].to_f
    end

    private

    def branch_info
      @branch_info ||= @codeclimate_api.branch_info(@branch)
    end
  end
end