<script>
  import { onMount } from 'svelte';
  import L from 'leaflet';
  import 'leaflet.markercluster';
  import 'leaflet/dist/leaflet.css';
  import 'leaflet.markercluster/dist/MarkerCluster.css';
  import 'leaflet.markercluster/dist/MarkerCluster.Default.css';

  const API_URL = 'https://dados.curvelo.mg.gov.br';

  const layerGroups = [
    { 
      'name': 'Limites administrativos',
      'layers': ['layer3', 'layer4', 'layer5']
    },
    {
      'name': 'Equipamentos',
      'layers': ['layer20', 'layer21', 'layer22', 'layer23']
    },
    {
      'name': 'Habitação',
      'layers': ['layer24']
    },
    {
      'name': 'Informações imobiliárias',
      'layers': ['layer6', 'layer10', 'layer13', 'layer14', 'layer15', 'layer16', 'layer17', 'layer18', 'layer19']
    },
    {
      'name': 'Licenciamento',
      'layers': ['layer25', 'layer26', 'layer27']
    },
    {
      'name': 'Regularização fundiária',
      'layers': ['layer28']
    },
    { 
      'name': 'Infraestrutura urbana',
      'layers': ['layer8', 'layer9']
    },
    { 
      'name': 'Legislação urbana',
      'layers': ['layer1', 'layer2', 'layer12']
    },
    { 
      'name': 'Meio físico',
      'layers': ['layer7']
    }
  ]
  
  const layerConfig = [
    {
      id: 'layer1',
      name: 'Macrozoneamento',
      type: 'polygon',
      url: API_URL + '/dataset/82e1c7c3-6341-46df-9a17-aa3c3383a4c6/resource/fe906a2a-a40f-4992-bcf3-bfb10935ecc6/download/macrozoneamento.geojson',
      style: {
         fillColor: 'rgba(200, 200, 0, 0.2)',
         color: '#AAAA00',
         weight: 2,
      }
    },

    {
      id: 'layer2',
      name: 'LC_176_2022',
      type: 'polygon',
      url: API_URL + '/dataset/7b45c447-1004-471a-97ff-fd1af1dcd34c/resource/ec73a44b-a1ef-4d09-9eca-b04c272b033b/download/lc_176_2022.geojson',
      style: {
         fillColor: 'rgba(0, 200, 0, 0.4)',
         color: '#00ff00',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer3',
      name: 'Limite município',
      type: 'polygon',

      url: API_URL + '/dataset/d09ac556-f935-416a-9fb6-0f54c28e2f91/resource/30b43ca9-8353-439a-b88c-2f56c7784396/download/limite_municipio.geojson',
      style: {
         fillColor: 'rgba(0, 200, 200, 0.4)',
         color: '#00ff00',
         weight: 2,
         pointRadius: 5,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer4',
      name: 'Limite urbano',
      type: 'polygon',

      url: API_URL + '/dataset/d09ac556-f935-416a-9fb6-0f54c28e2f91/resource/f015aaf9-d26b-491c-878a-14fdf8522074/download/limite_perurbano.geojson',
      style: {
         fillColor: 'rgba(0, 200, 200, 0.4)',
         color: '#00ff00',
         weight: 2,
         pointRadius: 5,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer5',
      name: 'Limite rural',
      type: 'polygon',

      url: API_URL + '/dataset/d09ac556-f935-416a-9fb6-0f54c28e2f91/resource/8132bb0a-fcd4-4fdf-9d68-1d276eaafd62/download/limite_perrural.geojson',
      style: {
         fillColor: 'rgba(0, 200, 200, 0.4)',
         color: '#00ff00',
         weight: 2,
         pointRadius: 5,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer6',
      name: 'Lotes',
      type: 'polygon',

      url: API_URL + '/dataset/95e57e53-8467-4784-9f0a-3c3a2fe48a18/resource/5fcfbc2d-27c8-4099-a83b-81bcfd457018/download/lotes.geojson',
      style: {
         fillColor: 'rgba(255, 0, 255, 0.2)',
         color: '#ff00ff',
         weight: 1,
         fillOpacity: 0.3
      }
    },
    {
      id: 'layer7',
      name: 'Áreas verdes dos loteamentos ',
      type: 'polygon',

      url: API_URL + '/dataset/a8d71a59-b211-4e43-ba3d-05336891ba3b/resource/4be28723-e4be-4e23-90e5-2ce155104f9a/download/area_verde_loteamentos.geojson',
      style: {
         color: '#0088FF',
         weight: 1,
         pointRadius: 2,
         radius: 5,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer8',
      name: 'Passeios',
      type: 'point',

      url: API_URL + '/dataset/007aec9b-cdef-40f7-b92a-89fcff04c7a3/resource/8f11730b-acca-4726-83a4-c0288ceb008f/download/passeios.geojson',
      style: {
         fillColor: 'rgba(100, 100, 255, 0.4)',
         color: '#8888FF',
         weight: 2,
         pointRadius: 2,
         radius: 2,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer9',
      name: 'Logradouros',
      type: 'point',

      url: API_URL + '/dataset/b1dcffa6-c7bd-42e8-93f5-52b5ea5f4f92/resource/65d8f7ac-cf7a-4e17-b490-b3d9e0b740dc/download/trecho_logradouro.geojson',
      style: {
         fillColor: 'rgba(100, 100, 255, 0.4)',
         color: '#8888FF',
         weight: 2,
         pointRadius: 2,
         radius: 2,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer10',
      name: 'Imóveis município',
      type: 'polygon',

      url: API_URL + '/dataset/5ff3ea1b-8c71-4e22-9038-35ab05f6d7ea/resource/2a22b47f-0a83-42f1-9a62-7f687e87f8ac/download/imoveis_municipio.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer11',
      name: 'Logradouros',
      type: 'polygon',

      url: API_URL + '/dataset/b1dcffa6-c7bd-42e8-93f5-52b5ea5f4f92/resource/fd1a784d-7ad4-4fee-b414-18a6c2bd0eb1/download/logradouros_08_2024.geojson',
      style: {
         fillColor: 'rgba(0, 0, 255, 0.2)',
         color: '#0000FF',
         weight: 2,
         pointRadius: 5,
         pointFill: '#0000ff'
      }
    },
    {
      id: 'layer12',
      name: 'Hierarquia viária',
      type: 'polygon',

      url: API_URL + '/dataset/87aee15c-d16d-465c-833c-61c32b90e8ff/resource/9557013e-5739-4758-bc01-d1c332cb86c8/download/hierarquia_viaria.geojson',
      style: {
         fillColor: 'rgba(0, 255, 255, 0.2)',
         color: '#00FFFF',
         weight: 2,
         pointRadius: 5,
         pointFill: '#00ffff'
      }
    },
    {
      id: 'layer13',
      name: 'Edificação',
      type: 'polygon',

      url: API_URL + '/dataset/01dc01aa-c734-4ef1-b4f5-f6f5378310df/resource/d65f3c99-9850-4083-837a-0bd39eeb10c4/download/edificacao.geojson',
      style: {
         fillColor: 'rgba(0, 255, 255, 0.2)',
         color: '#FFAA00',
         weight: 2,
         pointRadius: 5,
         pointFill: '#00ffff'
      }
    },
    {
      id: 'layer14',
      name: 'Inscrição cadastral',
      type: 'point',

      url: API_URL + '/dataset/4d4ace36-53f3-4b1c-8ecd-2cb728fc8bbc/resource/c20eca97-3287-4f62-a701-a81737b03a68/download/inscricao_cadastral.geojson',
      style: {
         fillColor: 'rgba(0, 0, 255, 0.2)',
         color: '#FF88FF',
         weight: 2,
         pointRadius: 2,
         radius: 2,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer15',
      name: 'Bairros',
      type: 'polygon',

      url: API_URL + '/dataset/2cf4267d-be96-465a-af0a-a0ce5de9d485/resource/29a01453-46f7-40b6-b67a-ebb2b4b4d249/download/bairros.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer16',
      name: 'Quadras',
      type: 'polygon',

      url: API_URL + '/dataset/f3cb5d43-5f41-47a1-b8c4-b1f3b962b76f/resource/76acb62d-f1d4-4efa-92a0-c171e56b0e19/download/quadras.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer17',
      name: 'APP',
      type: 'polygon',

      url: API_URL + '/dataset/fa8cbd9c-bfdf-44e6-b220-2f008c0d127b/resource/266fa1e1-fb06-4c3a-b25b-1b269551dabb/download/app.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer18',
      name: 'Zonas fiscais',
      type: 'polygon',

      url: API_URL + '/dataset/219ae8ba-5d07-4df5-8092-69315090609f/resource/742ca91e-b959-46d8-aa47-449814875dfd/download/zonas_fiscais.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer19',
      name: 'Áreas institucionais dos loteamentos',
      type: 'polygon',

      url: API_URL + '/dataset/1aa76d64-bf9e-41b3-bed4-1047533fff24/resource/8ce2a816-b319-4301-b114-9f51277188b8/download/area_institucional_loteamentos.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer20',
      name: 'Educação',
      type: 'polygon',

      url: API_URL + '/dataset/f5ea0755-f60b-45c7-9331-496700acb2a9/resource/f8222461-79a5-436d-8b56-62f3751e10c7/download/educacao.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer21',
      name: 'Escolas',
      type: 'polygon',

      url: API_URL + '/dataset/0426cfca-22ec-4f79-ad30-d52cd2b785d2/resource/0345399c-8b61-4753-9973-84ac1079f94c/download/escolas.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer22',
      name: 'Assistência social administração',
      type: 'polygon',

      url: API_URL + '/dataset/c4ff27f8-dc82-475c-866a-d75e20837957/resource/d0b6741e-a6ae-425b-801c-b6361997c642/download/assistencia_social_administracao.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer23',
      name: 'Postos de saúde',
      type: 'polygon',

      url: API_URL + '/dataset/e05e3dfb-fb0a-4568-bb33-3737b9f65a23/resource/85acb4b0-9deb-4190-9afb-6b03d8aa967f/download/pontos_saude.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer24',
      name: 'Conjuntos habitacionais',
      type: 'polygon',

      url: API_URL + '/dataset/7a0c3f0e-6008-4f87-9276-b0cfc4fff7e6/resource/cacfc1a8-6b2a-4887-ab5d-226c0e8c5b0c/download/conjuntos_habitacionais.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer25',
      name: 'Alvarás urbanísticos',
      type: 'polygon',

      url: API_URL + '/dataset/f29a2ae0-e934-417b-b07d-d197c4c1b701/resource/41974147-e4e4-44f7-9ad9-e95ce6b75403/download/alvaras_urbanisticos.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer26',
      name: 'Alvarás',
      type: 'point',

      url: API_URL + '/dataset/e9b3cf11-0d82-4623-8996-bc170ddd036c/resource/96ac5838-ff63-4375-8b21-dbf752903649/download/alvaras.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer27',
      name: 'Loteamento',
      type: 'polygon',

      url: API_URL + '/dataset/62c8eb86-b286-4819-91c9-48febfb1729c/resource/dd1eb84e-dbec-4995-8504-d6e344dc656c/download/loteamento.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer28',
      name: 'REURB',
      type: 'polygon',

      url: API_URL + '/dataset/fb1c5351-4e0f-4e85-a475-3b168d18d1e7/resource/09bd2f53-35d2-4a1f-a0c8-b15a7f60cd15/download/reurb.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
  ];

  function layer_source(layer_url) {
    const url_parts = layer_url.split('/');
    return url_parts.slice(0, url_parts.length - 2).join('/');
  }

  let map;
  let layers = new Map();
  let selectedLayers = new Set();
  let loadingStates = new Map();
  let isMenuCollapsed = false;

  // Create custom logo control
  const LogoControl = L.Control.extend({
    onAdd: function(map) {
      const container = L.DomUtil.create('div', 'logo-control');
      const img = L.DomUtil.create('img', 'logo-image', container);
      img.alt = 'Curvelo Aberta';

      img.src = 'https://dados.curvelo.mg.gov.br/uploads/admin/2025-02-06-052313.446052curvelo-aberta-logo.png';
      img.onclick = () => window.open('', '_blank');

      // Prevent click events from propagating to the map
      L.DomEvent.disableClickPropagation(container);
      return container;
    }
  });

  onMount(() => {
    map = L.map('map').setView([-18.7587401,-44.46470720], 12);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    new LogoControl({ position: 'topright' }).addTo(map);

  });

  function createLayerGroup(config, geojsonData) {
    switch(config.type) {
      case 'point':
        const markerCluster = L.markerClusterGroup({
          chunkedLoading: true,
          maxClusterRadius: 50,
          spiderfyOnMaxZoom: false,
          disableClusteringAtZoom: 14
        });

        L.geoJSON(geojsonData, {
          pointToLayer: (feature, latlng) => {
            return L.circleMarker(latlng, config.style);
          },
          onEachFeature: (feature, layer) => {
            if (feature.properties) {
              layer.bindPopup(() => {
                return formatPopupContent(feature.properties);
              });
            }
          }
        }).addTo(markerCluster);

        return markerCluster;

      case 'polygon':
      case 'line':
        return L.geoJSON(geojsonData, {
          style: config.style,
          onEachFeature: (feature, layer) => {
            if (feature.properties) {
              layer.bindPopup(() => {
                return formatPopupContent(feature.properties);
              });
            }

            // Add hover effect for polygons and lines
            if (config.type === 'polygon') {
              layer.on({
                mouseover: (e) => {
                  const layer = e.target;
                  layer.setStyle({
                    weight: 3,
                    fillOpacity: 0.7
                  });
                },
                mouseout: (e) => {
                  const layer = e.target;
                  layer.setStyle(config.style);
                }
              });
            }
          }
        });

      default:
        console.warn(`Unknown layer type: ${config.type}`);
        return null;
    }
  }

  function formatPopupContent(properties) {
    return Object.entries(properties)
      .map(([key, value]) => `<strong>${key}:</strong> ${value}`)
      .join('<br>');
  }

  async function loadLayer(config) {
    try {
      loadingStates.set(config.id, '⌛');
      loadingStates = loadingStates;

      const response = await fetch(config.url);
      const data = await response.json();

      const layer = createLayerGroup(config, data);
      
      loadingStates.set(config.id, '✓');
      loadingStates = loadingStates;

      return layer;

    } catch (error) {
      console.error(`Error loading layer ${config.id}:`, error);
      loadingStates.set(config.id, 'error');
      loadingStates = loadingStates;
      throw error;
    }
  }

  async function toggleLayer(config) {
    try {
      if (selectedLayers.has(config.id)) {
        const layer = layers.get(config.id);
        if (layer) {
          map.removeLayer(layer);
        }
        selectedLayers.delete(config.id);
      } else {
        let layer = layers.get(config.id);
        
        if (!layer) {
          layer = await loadLayer(config);
          layers.set(config.id, layer);
        }
        
        map.addLayer(layer);
        selectedLayers.add(config.id);

        // Fit bounds to the layer if it's the first one being added
        if (selectedLayers.size === 1) {
          const bounds = layer.getBounds();
          if (bounds.isValid()) {
            map.fitBounds(bounds, { padding: [50, 50] });
          }
        }
      }
      selectedLayers = selectedLayers;
    } catch (error) {
      console.error(`Error toggling layer ${config.id}:`, error);
    }
  }

  function toggleMenu() {
    isMenuCollapsed = !isMenuCollapsed;
  }
</script>

<style>

  :global(.logo-image:hover) {
    transform: scale(1.05);
    transition: transform 0.2s ease;
  }

  :global(.logo-image) {
    max-width: 80px;
  }

  @media (max-width: 768px) {
    :global(.logo-image) {
      width: 80px;  /* Smaller on mobile */
    }
  }

  :global(html, body) {
    margin: 0;
    height: 100%;
    color: black;
  }
  
  .container {
    display: flex;
    height: 100vh;
  }
  
  .menu {
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0,0,0,0.1);
    z-index: 1000;
    display: flex;
    transition: all 0.3s ease;
    position: relative;
  }

  .menu.expanded {
    width: 250px;
  }

  .menu.collapsed {
    width: 40px;
  }

  .menu-content {
    width: 250px;
    padding: 1rem;
    overflow: hidden;
    transition: all 0.3s ease;
    transform-origin: left;
    font-size: 9pt;
    background: url('/curvelo-background.png');
  }

  .menu.collapsed .menu-content {
    transform: translateX(-210px);
  }

  .toggle-button {
    position: absolute;
    right: -12px;
    top: 50%;
    transform: translateY(-50%);
    width: 24px;
    height: 24px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1001;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
  }

  .menu.collapsed .toggle-button {
    transform: translateY(-50%) rotate(180deg);
  }

  .ckan-link {
    margin-left: 10px;
  }

  .toggle-icon {
    border: solid #666;
    border-width: 0 2px 2px 0;
    display: inline-block;
    padding: 3px;
    transform: rotate(135deg);
    margin-left: 3px;
  }
  
  .map-container {
    flex-grow: 1;
  }
  
  #map {
    width: 100%;
    height: 100%;
  }

  .layer-item {
    display: flex;
    align-items: center;
    padding: 0.5rem;
    margin-bottom: 0.5rem;
    background-color: white;
    border-radius: 4px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  }

  .layer-info {
    margin-left: 0.5rem;
    flex-grow: 1;
  }

  .layer-name {
    font-weight: 500;
  }

  .layer-status {
    font-size: 0.8rem;
    color: #666;
  }

  .loading {
    color: #2196F3;
  }

  .error {
    color: #f44336;
  }

  .loaded {
    color: #4CAF50;
  }

  .layers {
    background-color: white;
    overflow-y: scroll;
    max-height: 90%;
  }

  .checkbox {
    margin-right: 0.5rem;
  }
  
  /* Add styles for hover indicators */
  .layer-item {
    display: flex;
    align-items: center;
    padding: 0.5rem;
    margin-bottom: 0.5rem;
    background-color: white;
    border-radius: 4px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  }

  .layer-color-indicator {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    margin-right: 10px;
    border: 1px solid #ddd;
  }

  .loading {
    color: #2196F3;
  }

  .error {
    color: #f44336;
  }

  .loaded {
    color: #4CAF50;
  }
</style>

<div class="container">
  <div class="menu {isMenuCollapsed ? 'collapsed' : 'expanded'}">
    <div class="menu-content">
      <div class="layers">
      {#each layerGroups as layerGroup}
        <h3>{layerGroup['name']}</h3>
      {#each layerConfig as layer}
        {#if layerGroup['layers'].includes(layer['id'])}
        <div class="layer-item">
          <input
            type="checkbox"
            class="checkbox"
            checked={selectedLayers.has(layer.id)}
            on:change={() => toggleLayer(layer)}
          />
          <div class="layer-info">
            <div style="float: left" class="layer-name">{layer.name}</div>
            {#if loadingStates.get(layer.id)}
              <div style="float: right" class="layer-status {loadingStates.get(layer.id)}">
                {loadingStates.get(layer.id)}
              </div>
            {/if}
            <a class="ckan-link" target="_blank" href="{layer_source(layer.url)}">⬇️</a>
          </div>
        </div>
        {/if}
        {/each}
      {/each}
      </div>
    </div>
    <button class="toggle-button" on:click={toggleMenu}>
      <span class="toggle-icon"></span>
    </button>
  </div>
  
  <div class="map-container">
    <div id="map"></div>
  </div>
</div>
