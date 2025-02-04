<script>
  import { onMount } from 'svelte';
  import Map from 'ol/Map';
  import View from 'ol/View';
  import TileLayer from 'ol/layer/Tile';
  import VectorLayer from 'ol/layer/Vector';
  import VectorSource from 'ol/source/Vector';
  import OSM from 'ol/source/OSM';
  import GeoJSON from 'ol/format/GeoJSON';
  import { fromLonLat } from 'ol/proj';
  import * as style from "ol/style";
  import Style from 'ol/style/Style';
  import Fill from 'ol/style/Fill';
  import Stroke from 'ol/style/Stroke';
  import Circle from 'ol/style/Circle';
  import Text from 'ol/style/Text';
  import Overlay from 'ol/Overlay';
  
  // Sample layer configuration - replace with your API endpoint
  const layerConfig = [
    {
      id: 'layer8',
      name: 'Macrozoneamento',
      url: 'https://curvelo.vaz.io/dataset/716c0bf0-6b54-4b8a-b07f-79985cf672e6/resource/d6609383-4485-4a3d-8ba5-a9cde647e02c/download/macrozoneamento.geojson',
      style: {
         fill: 'rgba(200, 200, 0, 0.2)',
         stroke: '#AAAA00',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#00ffff'
      }
    },


    {
      id: 'layer3',
      name: 'Perímetro Rural',
      url: 'https://curvelo.vaz.io/dataset/31bbb8a5-eaad-4952-802f-267d898224f0/resource/ab706115-d919-4323-bc96-8f39632d2ad1/download/perimetro_rural.geojson',
      style: {
         fill: 'rgba(0, 200, 0, 0.4)',
         stroke: '#00ff00',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer4',
      name: 'Limite Urbano',
      url: 'https://curvelo.vaz.io/dataset/ce0b8798-bc4c-4d5e-b87c-6a4c46dbb92f/resource/bbcfba99-aabf-453b-96bc-416f39f0f90b/download/limite_perurbano.geojson',
      style: {
         fill: 'rgba(0, 200, 200, 0.4)',
         stroke: '#00ff00',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer9',
      name: 'Lote',
      url: 'https://curvelo.vaz.io/dataset/fea1bfd1-2125-4c97-995d-851aac5f2546/resource/016bd908-fdf0-4c4e-b476-9d4d2aaf310a/download/lote_08_2024.geojson',
      style: {
         fill: 'rgba(255, 0, 255, 0.2)',
         stroke: '#ff00ff',
         strokeWidth: 1,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer10',
      name: 'Hidro Curvelo',
      url: 'https://curvelo.vaz.io/dataset/33db52bf-c019-48c6-a285-e145bf24936d/resource/0711f0ea-2ae9-4518-bdd5-358b037da184/download/hidro_curvelo.geojson',
      style: {
         fill: 'rgba(0, 100, 255, 0.4)',
         stroke: '#0088FF',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer11',
      name: 'Pontos de Iluminação',
      url: 'https://curvelo.vaz.io/dataset/8749164d-a544-4e00-ae7f-cc5a00069800/resource/180a115c-f0ab-47bd-8896-5952a96da00f/download/pontos_iluminacao.geojson',
      style: {
         fill: 'rgba(100, 100, 255, 0.4)',
         stroke: '#8888FF',
         strokeWidth: 2,
         pointRadius: 2,
         pointFill: '#00DDDD'
      }
    },
    {
      id: 'layer1',
      name: 'Imóveis',
      url: 'https://curvelo.vaz.io/dataset/c5be57f5-053b-4f40-bff1-9ce58fac0c75/resource/4301a430-0d1d-4daf-8086-f26239333faf/download/imoveis.geojson',
      style: {
         fill: 'rgba(255, 0, 0, 0.2)',
         stroke: '#ff0000',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#ff0000'
      }
    },
    {
      id: 'layer2',
      name: 'Logradouros',
      url: 'https://curvelo.vaz.io/dataset/0f68f155-2cfb-4862-b31a-f21445ff9a61/resource/501540e5-90b4-434e-80a7-a4d3b7d114da/download/logradouros_08_2024.geojson',
      style: {
         fill: 'rgba(0, 0, 255, 0.2)',
         stroke: '#0000FF',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#0000ff'
      }
    },
    {
      id: 'layer6',
      name: 'Hierarquia Viária PD',
      url: 'https://curvelo.vaz.io/dataset/4f551b93-dd8c-47b0-8074-24f33e9a4d53/resource/860b5acf-48c4-461c-a6cc-ebe71d849686/download/hierarquia_viaria_pd.geojson',
      style: {
         fill: 'rgba(0, 255, 255, 0.2)',
         stroke: '#00FFFF',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#00ffff'
      }
    },
    {
      id: 'layer7',
      name: 'Edificações',
      url: 'https://curvelo.vaz.io/dataset/3b9826eb-1436-438f-9b09-d8809fb981c3/resource/79b14382-c5c2-4fcf-850d-e26b3dc31742/download/edificacoes.geojson',
      style: {
         fill: 'rgba(0, 255, 255, 0.2)',
         stroke: '#FFAA00',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#00ffff'
      }
    },


    {
      id: 'layer5',
      name: 'Inscrições cadastrais',
      url: 'https://curvelo.vaz.io/dataset/916257e3-647a-46b7-9a89-d08560d4b3fe/resource/f8c2e275-f9bf-435e-9f1b-9c51c1294776/download/inscricoes_cadastrais_08_2024.geojson',
      style: {
         fill: 'rgba(0, 0, 255, 0.2)',
         stroke: '#0000FF',
         strokeWidth: 2,
         pointRadius: 5,
         pointFill: '#0000ff'
      }
    },


  ];

  let map;
  let isMenuCollapsed = false;
  let layers = new Map(); // Map to store layer references
  let selectedLayers = new Set(); // Track selected layers
  let tooltip;
  let popup;
  let tooltipElement;
  let popupElement;
  let popupContent;
  let popupCloser;

  // Format feature properties for display
  function formatProperties(properties) {
    return Object.entries(properties)
      .filter(([key]) => key !== 'geometry') // Exclude geometry
      .map(([key, value]) => `<strong>${key}:</strong> ${value}`)
      .join('<br>');
  }

  // Initialize the map
  onMount(async () => {
    // Create tooltip element
    tooltipElement = document.createElement('div');
    tooltipElement.className = 'tooltip';
    tooltip = new Overlay({
      element: tooltipElement,
      offset: [10, 0],
      positioning: 'bottom-left'
    });

    // Create popup element
    popupElement = document.createElement('div');
    popupElement.className = 'popup';

    // Create closer button
    popupCloser = document.createElement('a');
    popupCloser.className = 'popup-closer';
    popupCloser.href = '#';
    popupElement.appendChild(popupCloser);

    // Create content container
    popupContent = document.createElement('div');
    popupContent.className = 'popup-content';
    popupElement.appendChild(popupContent);

    // Create popup overlay
    popup = new Overlay({
      element: popupElement,
      autoPan: true,
      autoPanAnimation: {
        duration: 250
      }
    });

    // Close popup on click
    popupCloser.onclick = () => {
      popup.setPosition(undefined);
      popupCloser.blur();
      return false;
    };

    map = new Map({
      target: 'map',
      layers: [
        new TileLayer({
          source: new OSM()
        })
      ],
      overlays: [tooltip, popup],
      view: new View({
        center: fromLonLat([-44.46470720, -18.7587401]),
        zoom: 12 
      })
    });

    // Initialize vector layers
    for (const lc of layerConfig) {
      const vectorSource = new VectorSource({
        format: new GeoJSON(),
        url: lc.url,
      });

      const vectorLayer = new VectorLayer({
        source: vectorSource,
        visible: false,
        style: createStyleFunction(lc.style),
      });

      layers.set(lc.id, vectorLayer);
      map.addLayer(vectorLayer);
    }

    // Handle pointer movement for tooltip
    map.on('pointermove', (evt) => {
      const hit = map.hasFeatureAtPixel(evt.pixel);
      map.getTargetElement().style.cursor = hit ? 'pointer' : '';

      if (hit) {
        const feature = map.forEachFeatureAtPixel(evt.pixel, (feature) => feature);
        if (feature) {
          const properties = feature.getProperties();
          tooltipElement.innerHTML = properties.id || 'Clique para ver os dados';
          tooltip.setPosition(evt.coordinate);
        }
      } else {
        tooltip.setPosition(undefined);
      }
    });

    // Handle click for popup
    map.on('click', (evt) => {
      const feature = map.forEachFeatureAtPixel(evt.pixel, (feature) => feature);

      if (feature) {
        const properties = feature.getProperties();
        popupContent.innerHTML = formatProperties(properties);
        popup.setPosition(evt.coordinate);
      } else {
        popup.setPosition(undefined);
      }
    });
  });

  // Create style function for vector features
  function createStyleFunction(styleConfig) {
    return (feature) => {
      const geometry = feature.getGeometry().getType();

      // Basic styles
      const styles = {
        fill: new Fill({
          color: styleConfig.fill
        }),
        stroke: new Stroke({
          color: styleConfig.stroke,
          width: styleConfig.strokeWidth
        })
      };

      // Point style
      const pointStyle = new Style({
        image: new Circle({
          radius: styleConfig.pointRadius,
          fill: new Fill({
            color: styleConfig.pointFill
          }),
          stroke: new Stroke({
            color: styleConfig.stroke,
            width: 1
          })
        })
      });

      // Line style
      const lineStyle = new Style({
        stroke: styles.stroke
      });

      // Polygon style
      const polygonStyle = new Style({
        fill: styles.fill,
        stroke: styles.stroke
      });

      // Return appropriate style based on geometry type
      switch (geometry) {
        case 'Point':
        case 'MultiPoint':
          return pointStyle;
        case 'LineString':
        case 'MultiLineString':
          return lineStyle;
        case 'Polygon':
        case 'MultiPolygon':
          return polygonStyle;
        default:
          return polygonStyle;
      }
    };
  }

  // Toggle layer visibility
  function toggleLayer(layerId) {
    const layer = layers.get(layerId);
    if (layer) {
      if (selectedLayers.has(layerId)) {
        selectedLayers.delete(layerId);
        layer.setVisible(false);
      } else {
        selectedLayers.add(layerId);
        console.log(layer)
        layer.setVisible(true);
      }
      selectedLayers = selectedLayers; // trigger reactivity
    }
  }

  function toggleMenu() {
    isMenuCollapsed = !isMenuCollapsed;
    // Update map size after animation completes
    setTimeout(() => {
      map?.updateSize();
    }, 300);
  }

</script>

<style>
  :global(html, body) {
    margin: 0;
    height: 100%;
  }
  
  .container {
    display: flex;
    height: 100vh;
  }
  
  .menu {
    width: 250px;
    padding: 1rem;
    color: black;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0,0,0,0.1);
    z-index: 1000;
    position: relative;
  }

  .menu.expanded {
    width: 250px;
    transition: all 0.3s ease;
  }

  .menu.collapsed {
    width: 10px;
    transition: all 0.3s ease;
  }

  .menu-content {
    width: 250px;
    overflow: hidden;
    transition: all 0.3s ease;
    transform-origin: left;
    position: relative;
  }

  .menu.collapsed .menu-content {
    transform: translateX(-210px);
    transition: all 0.3s ease;

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

  .toggle-button:hover {
    background-color: #f0f0f0;
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
    cursor: pointer;
    user-select: none;
  }
  
  .layer-item:hover {
    background-color: #e9ecef;
  }
  
  .checkbox {
    margin-right: 0.5rem;
  }

    /* Tooltip style */
  :global(.tooltip) {
    position: relative;
    background: rgba(0, 0, 0, 0.8);
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    white-space: nowrap;
  }

  /* Popup style */
  :global(.popup) {
    position: absolute;
    background-color: white;
    box-shadow: 0 1px 4px rgba(0,0,0,0.2);
    padding: 15px;
    border-radius: 10px;
    border: 1px solid #cccccc;
    bottom: 12px;
    left: -50px;
    min-width: 280px;
    color: black;
  }

  :global(.popup-closer) {
    text-decoration: none;
    position: absolute;
    top: 2px;
    right: 8px;
    color: #666;
  }

  :global(.popup-closer:after) {
    content: "✖";
  }

  :global(.popup-content) {
    margin-top: 10px;
    margin-right: 20px;
  }

  :global(.ol-attribution) {
    display: none;
  }

</style>

<div class="container">
  <div class="menu {isMenuCollapsed ? 'collapsed' : 'expanded'}">
    <div class="menu-content">
      <div class="menu-header">
        <h2>Camadas</h2>
      </div>
      <div class="layer-list">
      {#each layerConfig as layer}
        <div class="layer-item">
          <input
            type="checkbox"
            class="checkbox"
            checked={selectedLayers.has(layer.id)}
            on:change={() => toggleLayer(layer.id)}
          />
          <span>{layer.name}</span>
        </div>
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
