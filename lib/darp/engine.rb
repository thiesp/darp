require 'darp'

module Darp
  class Engine < ::Rails::Engine
    isolate_namespace Darp

    ActiveSupport.on_load(:action_controller_base) {
      ActionController::Base.class_eval do
        def DARP_enqueue(job, job_params = nil, filename = nil)
          self.class.send :include, Darp
          enqueue(job, params[:darp_uuid], params[:darp_download], params[:darp_restore_id], job_params, filename)
        end
      end
    }

    ActiveSupport.on_load(:action_view) {
      require_relative '../../app/helpers/darp/darp_helper'
      include DarpHelper
    }
  end
end
