module ControllerHelper
  def update(object, object_params)
    respond_to do |format|
      if object.update(object_params)
        format.html { redirect_to object, notice: "#{object.class.name} club was successfully updated." }
        format.json { render action: 'show', status: :ok, location: object }
      else
        format.html { render action: 'edit' }
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
  end
end
