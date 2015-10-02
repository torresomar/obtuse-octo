class Layer
  attr_accessor :cv_edu, :edu, :cv_mun ,:mun ,:pob ,:pobreza_pct, 
    :pobreza_pob, :extrema_pct, :extrema_pob, :moderada_pct, :moderada_pob, 
    :vulnerables_c_pct, :vulnerables_c_pob, :vulnerables_i_pct, :vulnerables_i_pob, 
    :rez_edu_pct , :rez_edu_pob ,:rez_serv_salud_pct,:rez_serv_salud_pob,:rez_seg_social_pct,
    :rez_seg_social_pob,:rez_esp_viv_pct,:rez_esp_viv_pob,:rez_serv_viv_pct,:rez_serv_viv_pob,
    :rez_alim_pct,:rez_alim_pob,:ing_inf_bie_pct,:ing_inf_bie_pob,:ing_inf_min_pct,:ing_inf_min_pob,:gini,:razon_ingreso

  def initialize args
    args.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end
end

