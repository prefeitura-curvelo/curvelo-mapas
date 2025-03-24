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
      'layers': ['layer12', 'layer4', 'layer13']
    },
    { 
      'name': 'Cadastro',
      'layers': ['layer5', 'layer7', 'layer2', 'layer9', 'layer1']
    },
    // 'Equipamentos': [],
    { 
      'name': 'Infraestrutura urbana',
      'layers': ['layer14', 'layer11']
    },
    { 
      'name': 'Legislação urbana',
      'layers': ['layer6', 'layer8', 'layer3']
    },
    { 
      'name': 'Meio físico',
      'layers': ['layer10']
    }
  ]
  
  const layerConfig = [
    {
      id: 'layer8',
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
      id: 'layer3',
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
      id: 'layer12',
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
      id: 'layer13',
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
      id: 'layer9',
      name: 'Lote',
      type: 'polygon',

      url: API_URL + '/dataset/95e57e53-8467-4784-9f0a-3c3a2fe48a18/resource/d20b34a8-c322-409d-b2f9-a7715438af01/download/lote_08_2024.geojson',
      style: {
         fillColor: 'rgba(255, 0, 255, 0.2)',
         color: '#ff00ff',
         weight: 1,
         fillOpacity: 0.3
      }
    },
    {
      id: 'layer10',
      name: 'Áreas verdes dos loteamentos ',
      type: 'polygon',

      url: API_URL + '/dataset/a8d71a59-b211-4e43-ba3d-05336891ba3b/resource/4be28723-e4be-4e23-90e5-2ce155104f9a/download/area_verde_loteamentos.geojson',
      style: {
         color: '#0088FF',
         weight: 1,
         pointRadius: 2,
         radius: 5,
//         color: 'blue',
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer11',
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
      id: 'layer14',
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
      id: 'layer1',
      name: 'Imóveis públicos',
      type: 'polygon',

      url: API_URL + '/dataset/45fda47d-82fd-4bea-98c3-8e39ac5fa7ec/resource/f6a9270f-607e-4ed1-bd3e-82260f33ccd4/download/imoveis.geojson',
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
      id: 'layer6',
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
      id: 'layer7',
      name: 'Edificações',
      type: 'polygon',

      url: API_URL + '/dataset/01dc01aa-c734-4ef1-b4f5-f6f5378310df/resource/f3d859f3-2661-4e5a-9e4b-23c0f253a8ae/download/edificacoes.geojson',
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

      url: API_URL + '/dataset/4d4ace36-53f3-4b1c-8ecd-2cb728fc8bbc/resource/371e00e2-a7d6-4b98-aacc-846c9e57faef/download/inscricoes_cadastrais_08_2024.geojson',
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
