require 'test_helper'
require 'rails/performance_test_help'

class AcessosTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { runs: 1, metrics: [:wall_time, :memory],
  output: 'tmp/performance', formats: [:flat] }

  def test_creation

  	Contato.create :nome => 'Teste Performance', :email => 'teste_performance@gmail.com'
  	
  	$runs = 1000;
  	$i = 0;
  	
  	while $i < $runs  do
  		Acesso.create :contato_id => '1', :pagina => 'Home'
	   	$i +=1
	end

  end

  def test_get

    @acesso = Acesso.order('created_at DESC').limit(50)
    $acesso = @acesso.as_json

  end

end
