module ApplicationHelper
  def display_navbar_session_links
    capture do
      if user_signed_in?
        concat link_to "Domov", root_path, class: 'w3-bar-item w3-button w3-text-white'
        concat link_to "Moj Profil", edit_user_registration_path, class: 'w3-bar-item w3-button w3-text-white'
        concat link_to "My Favorites", favorites_path, class: 'w3-bar-item w3-button w3-text-white'
        if current_user.admin == true
          concat link_to "Admin", rails_admin_path, class: 'w3-bar-item w3-button w3-text-white'
        end
        concat link_to "Odjava", destroy_user_session_path, :method => :delete, class: 'w3-bar-item w3-button w3-text-white'
      else
        concat link_to "Domov", root_path, class: 'w3-bar-item w3-button w3-text-white'
        concat link_to "Prijava", new_user_session_path, class: 'w3-bar-item w3-button w3-text-white'
        concat link_to "Registracija", new_user_registration_path, class: 'w3-bar-item w3-button w3-text-white'
      end
    end
  end
end