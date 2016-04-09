class AcessosController < ApplicationController
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def new
  end

  def index
    @acesso = Acesso.order('created_at DESC').limit(50)
  end

  def show
    @acesso = Acesso.find(params[:id])
  end

  def create
  if Contato.exists?(id: acesso_params[:contato_id])
     @acesso = Acesso.new(acesso_params)
    @acesso.save
    render :json => { :status => 'ok', :acesso => @acesso.as_json }
    else
      render :json => { :status => 'error', :error => 'contato não encontrado' }
     end
  end

  private
  def acesso_params
    params.require(:acessos).permit(:pagina, :contato_id)
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
