Bwt::Application.routes.draw do
  root to: "Calculator#index"
  match "costs" => "Calculator#show"
end
