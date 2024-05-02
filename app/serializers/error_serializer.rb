class ErrorSerializer
  def self.serialize_json(error)
    {
      errors: [{
        detail: error.message
      }]
    }
  end
end