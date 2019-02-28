module Darp
  class GeneratorJob < ApplicationJob
    queue_as :default

    def generate(job_params)
      fail NotImplementedError, "generate method has to be implemented"
    end

    def perform(job_params, uuid)
      require "base64"

      darp = DarpGenerator.find_by_uuid(uuid)
      begin
        darp.update_attributes(content: Base64.encode64(generate(job_params)), status: :done)

        clean_old_data
      rescue
        darp.update_attributes(status: 'failed')
      end
    end

    private

    def clean_old_data
      DarpGenerator.where.not(status: :enqueued).where('updated_at < ?', 5.minutes.ago).destroy_all
      DarpGenerator.where('updated_at < ?', 1.day.ago).destroy_all
    end
  end
end
