class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def about
    # Página "Quiénes Somos"
  end

  def services
    # Página "Servicios"
    @services = [
      {
        name: "Estética Dental",
        description: "La estética dental es una rama de la odontología dedicada a resolver problemas relacionados con la armonía bucal, el objetivo principal es conseguir la sonrisa perfecta.",
        icon: "✨",
        discount: "50% de descuento"
      },
      {
        name: "Ortodoncia",
        description: "La ortodoncia se encarga de los problemas de los dientes y la mandíbula. Incluye el uso de dispositivos para enderezar los dientes y corregir problemas con la mordida.",
        icon: "🦷",
        discount: "50% de descuento"
      },
      {
        name: "Implantología",
        description: "La implantología dental se dedica al reemplazo de dientes perdidos mediante la colocación quirúrgica de un implante dental. Una de las técnicas más eficaces de rehabilitación dental.",
        icon: "🔧",
        discount: "50% de descuento"
      },
      {
        name: "Odontopediatría",
        description: "Especialidad dedicada al cuidado dental de niños y adolescentes. Ofrecemos un ambiente cómodo y tratamientos especializados para los más pequeños.",
        icon: "👶",
        discount: "Fluorización gratuita"
      }
    ]
  end

  def contact
    # Página "Contactos"
  end

  def contact_submit
    @name = params[:name]
    @email = params[:email]
    @phone = params[:phone]
    @subject = params[:subject]
    @message = params[:message]

    if [@name, @email, @phone, @subject, @message].any?(&:blank?)
      flash[:alert] = "Por favor completa todos los campos."
      redirect_to contact_path
      return
    end

    # Registrar en auditoría
    AuditService.log(
      action: "contact_form",
      resource_type: "Contact",
      resource_id: nil,
      details: "Mensaje de contacto de #{@name} (#{@email}) - Asunto: #{@subject}"
    )

    # En un sistema real, aquí enviarías el email al equipo
    flash[:notice] = "¡Gracias por contactarnos! Te responderemos en las próximas 24 horas."
    redirect_to contact_path
  end

  def newsletter_signup
    @email = params[:email]
    
    if @email.blank?
      flash[:alert] = "Por favor ingresa un email válido."
      redirect_back(fallback_location: root_path)
      return
    end

    # En un sistema real, aquí guardarías el email en una tabla de newsletter
    # Por ahora solo registramos en auditoría
    AuditService.log(
      action: "newsletter_signup",
      resource_type: "Newsletter",
      resource_id: nil,
      details: "Suscripción al newsletter: #{@email}"
    )

    flash[:notice] = "¡Gracias! Te has suscrito exitosamente a nuestro newsletter."
    redirect_back(fallback_location: root_path)
  end
end
