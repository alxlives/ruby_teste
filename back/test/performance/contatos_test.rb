require 'test_helper'
require 'rails/performance_test_help'

class ContatosTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { runs: 1, metrics: [:wall_time, :memory],
  output: 'tmp/performance', formats: [:flat] }

  def test_creation

  	$runs = 1000;
  	$i = 0;

  	while $i < $runs  do
  		Contato.create :nome => 'Teste Performance{i}', :email => 'teste_performance{i}@gmail.com'
	   	$i +=1
	end
    
  end

  def test_get

  	@contato = Contato.order('created_at DESC').limit(50)
    $contato = @contato.as_json

  end
 
 end
