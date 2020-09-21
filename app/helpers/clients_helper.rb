module ClientsHelper

  # METHODES DEFINISSANT LES FILTRES DE L'INDEX CLIENT - NE FONCTIONNE PAS, A INVESTIGUER (maintenu pour l'instant dans modèle client)
  def clients_segments_to_display
    Client.segments.unshift('Segment')
  end

  def clients_amap_to_display
    Client.amap.unshift('Amap')
  end

end
