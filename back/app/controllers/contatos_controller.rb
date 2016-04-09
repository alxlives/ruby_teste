class ContatosController < ApplicationController
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def new
  end

  def index
    @contato = Contato.order('created_at DESC').limit(50)
  end

  def show
    if Contato.exists?(id: params[:id])
      @contato = Contato.find(params[:id])
      render :json => { status: 'ok', :contato => contato.to_json }
    else
      render :json => { status: 'error', :error => 'contato não encontrado' }
    end
  end

  def create
    if Contato.exists?(email: contato_params[:email])
      @contato = Contato.find_by_email(contato_params[:email])
      render :json => { status: 'error', :error => 'contato já existente', :contato => @contato.as_json } 
    else
      @contato = Contato.new(contato_params)
      @contato.save
      render :json => { status: 'ok', :contato => @contato.as_json } 
    end

  end

  private
  def contato_params
    params.require(:contatos).permit(:nome, :email)
  end

    # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.
  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

end
