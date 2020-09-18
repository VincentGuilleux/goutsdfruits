module SiteHelper
  def client_non_admin?
    (current_client && current_client.role != "admin")
  end

  def client_shop?
    (current_client && current_client.segment == 'magasin')
  end

  def client_admin?
    current_client && current_client.role == "admin"
  end

  def client_not_logged?
    current_client.nil?
  end

end
