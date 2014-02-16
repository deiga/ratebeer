class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' unless current_user
  end

  protected

    def shared_update(object, object_params)
      respond_to do |format|
        if object.update(object_params)
          format.html { redirect_to object, notice: "#{object.class.model_name.human} club was successfully updated." }
          format.json { render action: 'show', status: :ok, location: object }
        else
          format.html { render action: 'edit' }
          format.json { render json: object.errors, status: :unprocessable_entity }
        end
      end
    end

    def shared_create(object, object_path=object)
      respond_to do |format|
      if object.save
        format.html { redirect_to object_path, notice: "#{object.class.model_name.human} was successfully created." }
        format.json { render action: 'show', status: :created, location: object }
      else
        format.html { render action: 'new' }
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
    end
end
