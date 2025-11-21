class AuditService
  def self.log(action:, resource:, user: nil, details: nil)
    AuditLog.create!(
      action: action,
      resource_type: resource.class.name,
      resource_id: resource.id,
      user: user,
      details: details,
      ip_address: Current.ip_address,
      user_agent: Current.user_agent
    )
  rescue => e
    Rails.logger.error "Failed to create audit log: #{e.message}"
  end
end
