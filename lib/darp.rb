require "darp/engine"

module Darp
  def enqueue(job, darp_uuid, download, restore_id, job_params, filename)
    if darp_uuid
      @darp_uuid = darp_uuid
      if download
        send_darp_file(darp_uuid, filename)
      else
        poll
      end
    else
      uuid = new_uuid
      setup_spinner(uuid, restore_id)
      start_darp_job(job, uuid, job_params)
    end
  end

  private

  def start_darp_job(job, uuid, job_params)
    job.perform_later(job_params, uuid)
  end


  def poll
    render json: {status: darp_data.status}
  end

  def setup_spinner(uuid, restore_id)
    @url = (request.path_info+"?darp_uuid=#{uuid}").html_safe
    @download_url = (request.path_info+"?darp_uuid=#{uuid}&darp_download=true").html_safe
    @restore_id = restore_id
    render template: "./darp/poller.js.erb", layout: false
  end

  def send_darp_file(uuid, filename)
    require "base64"
    darp = DarpGenerator.find_by_uuid(uuid)
    darp.destroy
    send_data(Base64.decode64(darp.content), filename: filename)
  end

  def darp_data
    @darp_data ||= DarpGenerator.find_by_uuid(@darp_uuid)
  end

  def new_uuid
    uuid = SecureRandom.hex(13)
    until DarpGenerator.create(uuid: uuid, status: :enqueued)
      uuid = SecureRandom.hex(13)
    end
    return uuid
  end
end
