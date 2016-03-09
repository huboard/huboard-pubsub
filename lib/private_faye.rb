class PrivateFaye
  def incoming(message, callback)
    if message["channel"] == "/meta/subscribe"
      authenticate_subscribe(message)
    elsif message["channel"] !~ %r{^/meta/}
      authenticate_publish(message)
    end
    callback.call(message)
  end

  def authenticate_subscribe(message)
    Faye.logger.info("!!! Attempting authenticated subscription for:")
    Faye.logger.info(message)
    Faye.logger.info("!!!")

    if message["ext"].nil?
      message["error"] = "Extension data is missing"
      return message
    end

    subscription = PrivatePub.subscription(:channel => message["subscription"], :timestamp => message["ext"]["private_pub_timestamp"])
    if message["ext"]["private_pub_signature"] != subscription[:signature]
      message["error"] = "Incorrect signature."
      Faye.logger.info "WARNING!!!"
      Faye.logger.info message["error"]
    elsif PrivatePub.signature_expired? message["ext"]["private_pub_timestamp"].to_i
      message["error"] = "Signature has expired."
      Faye.logger.info "WARNING!!!"
      Faye.logger.info message["error"]
    end
  end
  def authenticate_publish(message)
    if message["ext"].nil?
      message["error"] = "Extension data is missing"
      return message
    end

    if PrivatePub.config[:secret_token].nil?
      raise Error, "No secret_token config set, ensure private_pub.yml is loaded properly."
    elsif message["ext"]["private_pub_token"] != PrivatePub.config[:secret_token]
      message["error"] = "Incorrect token."
      Faye.logger.info "WARNING!!!"
      Faye.logger.info message["error"]
    else
      message["ext"]["private_pub_token"] = nil
    end
  end
end
