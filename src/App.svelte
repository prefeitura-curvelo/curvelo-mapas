<script>
  import { onMount } from 'svelte';
  import L from 'leaflet';
  import 'leaflet.markercluster';
  import 'leaflet/dist/leaflet.css';
  import 'leaflet.markercluster/dist/MarkerCluster.css';
  import 'leaflet.markercluster/dist/MarkerCluster.Default.css';

  const API_URL = 'https://mapas.curvelo.mg.gov.br';

  const layerGroups = [
    { 
      'name': 'Cadastro',
      'layers': ['layer5', 'layer7', 'layer2', 'layer9', 'layer1']
    },
    // 'Equipamentos': [],
    { 
      'name': 'Infraestrutura Urbana',
      'layers': ['layer11']
    },
    { 
      'name': 'Legislação Urbana',
      'layers': ['layer6', 'layer4', 'layer8', 'layer3']
    },
    { 
      'name': 'Meio Físico',
      'layers': ['layer10']
    }
  ]
  
  const layerConfig = [
    {
      id: 'layer8',
      name: 'Macrozoneamento',
      type: 'polygon',
      url: API_URL + '/dataset/716c0bf0-6b54-4b8a-b07f-79985cf672e6/resource/d6609383-4485-4a3d-8ba5-a9cde647e02c/download/macrozoneamento.geojson',
      style: {
         fillColor: 'rgba(200, 200, 0, 0.2)',
         color: '#AAAA00',
         weight: 2,
      }
    },

    {
      id: 'layer3',
      name: 'Perímetro Rural',
      type: 'polygon',
      url: API_URL + '/dataset/31bbb8a5-eaad-4952-802f-267d898224f0/resource/ab706115-d919-4323-bc96-8f39632d2ad1/download/perimetro_rural.geojson',
      style: {
         fillColor: 'rgba(0, 200, 0, 0.4)',
         color: '#00ff00',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer4',
      name: 'Limite Urbano',
      type: 'polygon',

      url: API_URL + '/dataset/ce0b8798-bc4c-4d5e-b87c-6a4c46dbb92f/resource/bbcfba99-aabf-453b-96bc-416f39f0f90b/download/limite_perurbano.geojson',
      style: {
         fillColor: 'rgba(0, 200, 200, 0.4)',
         color: '#00ff00',
         weight: 2,
         pointRadius: 5,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer9',
      name: 'Lote',
      type: 'polygon',

      url: API_URL + '/dataset/fea1bfd1-2125-4c97-995d-851aac5f2546/resource/016bd908-fdf0-4c4e-b476-9d4d2aaf310a/download/lote_08_2024.geojson',
      style: {
         fillColor: 'rgba(255, 0, 255, 0.2)',
         color: '#ff00ff',
         weight: 1,
         fillOpacity: 0.3
      }
    },
    {
      id: 'layer10',
      name: 'Hidro Curvelo',
      type: 'polygon',

      url: API_URL + '/dataset/33db52bf-c019-48c6-a285-e145bf24936d/resource/0711f0ea-2ae9-4518-bdd5-358b037da184/download/hidro_curvelo.geojson',
      style: {
         color: '#0088FF',
         weight: 1,
         pointRadius: 2,
         radius: 5,
         color: 'blue',
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer11',
      name: 'Iluminação pública',
      type: 'point',

      url: API_URL + '/dataset/8749164d-a544-4e00-ae7f-cc5a00069800/resource/180a115c-f0ab-47bd-8896-5952a96da00f/download/pontos_iluminacao.geojson',
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
      id: 'layer1',
      name: 'Imóveis Públicos',
      type: 'polygon',

      url: API_URL + '/dataset/c5be57f5-053b-4f40-bff1-9ce58fac0c75/resource/4301a430-0d1d-4daf-8086-f26239333faf/download/imoveis.geojson',
      style: {
         fillColor: 'rgba(255, 0, 0, 0.2)',
         color: '#ff0000',
         weight: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer2',
      name: 'Logradouros',
      type: 'polygon',

      url: API_URL + '/dataset/0f68f155-2cfb-4862-b31a-f21445ff9a61/resource/501540e5-90b4-434e-80a7-a4d3b7d114da/download/logradouros_08_2024.geojson',
      style: {
         fillColor: 'rgba(0, 0, 255, 0.2)',
         color: '#0000FF',
         weight: 2,
         pointRadius: 5,
         pointFill: '#0000ff'
      }
    },
    {
      id: 'layer6',
      name: 'Hierarquia Viária',
      type: 'polygon',

      url: API_URL + '/dataset/4f551b93-dd8c-47b0-8074-24f33e9a4d53/resource/860b5acf-48c4-461c-a6cc-ebe71d849686/download/hierarquia_viaria_pd.geojson',
      style: {
         fillColor: 'rgba(0, 255, 255, 0.2)',
         color: '#00FFFF',
         weight: 2,
         pointRadius: 5,
         pointFill: '#00ffff'
      }
    },
    {
      id: 'layer7',
      name: 'Edificações',
      type: 'polygon',

      url: API_URL + '/dataset/3b9826eb-1436-438f-9b09-d8809fb981c3/resource/79b14382-c5c2-4fcf-850d-e26b3dc31742/download/edificacoes.geojson',
      style: {
         fillColor: 'rgba(0, 255, 255, 0.2)',
         color: '#FFAA00',
         weight: 2,
         pointRadius: 5,
         pointFill: '#00ffff'
      }
    },


    {
      id: 'layer5',
      name: 'Inscrições cadastrais',
      type: 'point',

      url: API_URL + '/dataset/916257e3-647a-46b7-9a89-d08560d4b3fe/resource/f8c2e275-f9bf-435e-9f1b-9c51c1294776/download/inscricoes_cadastrais_08_2024.geojson',
      style: {
         fillColor: 'rgba(0, 0, 255, 0.2)',
         color: '#FF88FF',
         weight: 2,
         pointRadius: 2,
         radius: 2,
         pointFill: '#00DDDD'
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

      img.src = 'https://curvelo.vaz.io/uploads/admin/2024-10-30-204654.824686curvelo-aberta-logo.png';
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
    overflow: scroll;
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
      <h2>Camadas</h2>
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
