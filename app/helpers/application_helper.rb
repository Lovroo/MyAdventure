module ApplicationHelper
  def display_navbar_session_links
    capture do
      if user_signed_in?
        concat link_to "Domov", root_path, class: 'w3-bar-item w3-button w3-border-right'
        concat link_to "Moj Profil", edit_user_registration_path, class: 'w3-bar-item w3-button w3-border-right'
        concat link_to "Odjava", destroy_user_session_path, :method => :delete, class: 'w3-bar-item w3-button w3-border-right'
      else
        concat link_to "Domov", root_path, class: 'w3-bar-item w3-button w3-border-right'
        concat link_to "Prijava", new_user_session_path, class: 'w3-bar-item w3-button w3-border-right'
        concat link_to "Registracija", new_user_registration_path, class: 'w3-bar-item w3-button w3-border-right'
      end
    end
  end
end