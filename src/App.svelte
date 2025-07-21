<script>
  import { onMount } from 'svelte';
  import curveloLogo from './assets/curvelo-mapas.png';
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
    },
        { 
      'name': 'Zoneamento',
      'layers': ['layer40', 'layer41', 'layer42', 'layer43', 'layer44', 'layer45', 'layer46', 'layer47', 'layer48', 'layer49', 'layer50', 'layer51', 'layer52', 'layer53', 'layer54', 'layer55']
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
      type: 'polygon',

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
      type: 'polygon',

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
      type: 'icon',
      iconUrl: '/assets/18.png',
      iconSize: [32, 32],

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
      type: 'icon',
      iconUrl: '/assets/18.png',
      iconSize: [32, 32],
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
      type: 'point',

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
      type: 'icon',
      iconUrl: '/assets/20.png',
      iconSize: [32, 32],
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
      type: 'point',

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
// Zoneamento layer
    {
      id: 'layer40',
      name: 'ADE - 135',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/9e0888a3-f4ee-4c18-8bc7-47c5a8c5d6d8/download/ade_br_135.geojson',
      style: {
         fillColor: 'rgba(255, 182, 23, 0.2)',
         color: '#FFB617',
         weight: 2,
      }
    },
    {
      id: 'layer41',
      name: 'ADE - Central',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/434ab3ea-7a95-4892-9413-6977c5b71209/download/ade_c.geojson',
      style: {
         fillColor: 'rgba(131, 32, 238, 0.2)',
         color: '#8320EE',
         weight: 2,
      }
    },
      {
      id: 'layer42',
      name: 'ADE - Centralidades',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/aab7187e-044c-4770-bc29-a64b1360e7e1/download/ade_centra.geojson',
      style: {
         fillColor: 'rgba(0, 0, 255, 0.2)',
         color: '#0000FF',
         weight: 2,
      }
    },
    {
      id: 'layer43',
      name: 'ADE - Eixos de Verticalização',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/d7c375a3-b75e-4f09-b1af-d8f8c50e4f3c/download/ade_v.geojson',
      style: {
         fillColor: 'rgba(255, 128, 128, 0.2)',
         color: '#FF8080',
         weight: 2,
      }
    },
      {
      id: 'layer44',
      name: 'ZA - Zona Adensada',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/79ef8139-eec0-46f7-97cf-086f225e58df/download/za.geojson',
      style: {
         fillColor: 'rgba(255, 184, 52, 0.2)',
         color: '#FFB834',
         weight: 2,
      }
    },
    {
      id: 'layer45',
      name: 'ZAC - Zona de Adensamento Controlado',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/e39ba0cf-5d60-49a9-a714-77e4e6fb4f1c/download/zac.geojson',
      style: {
         fillColor: 'rgba(134, 14, 186, 0.2)',
         color: '#860EBA',
         weight: 2,
      }
    },
    {
      id: 'layer46',
      name: 'ZAP - Zona de Adensamento Prioritário',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/e686292c-e675-44d9-816f-b9ee075292b8/download/zap.geojson',
      style: {
         fillColor: 'rgba(245, 238, 97, 0.2)',
         color: '#F5EE61',
         weight: 2,
      }
    },
    {
      id: 'layer47',
      name: 'ZEIS I - Zona Especial de Interesse Social I',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/41d19f11-5ffd-498a-8040-0f92c409d883/download/zeis_i.geojson',
      style: {
         fillColor: 'rgba(236, 105, 227, 0.2)',
         color: '#EC69E3',
         weight: 2,
      }
    },
    {
      id: 'layer48',
      name: 'ZEP - Zona Econômica de Porte',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/d7071eec-da3e-4de8-a910-cc93b0f93e73/download/zep.geojson',
      style: {
         fillColor: 'rgba(253, 219, 255, 0.2)',
         color: '#FDDBFF',
         weight: 2,
      }
    },
    {
      id: 'layer49',
      name: 'ZIA - Zona de Interesse Aeroportuário',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/7414fafe-e777-4fa9-96a1-9867dac60ce9/download/zia.geojson',
      style: {
         fillColor: 'rgba(44, 170, 187, 0.2)',
         color: '#2CAABB',
         weight: 2,
      }
    },
    {
      id: 'layer50',
      name: 'ZMDHE - Zona Mista de Desenvolvimento Econômico e Habitação',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/24d4857f-4eba-4fc6-aac3-73179e1da0c2/download/zmdhe.geojson',
      style: {
         fillColor: 'rgba(162, 159, 150, 0.2)',
         color: '#A29F96',
         weight: 2,
      }
    },
    {
      id: 'layer51',
      name: 'ZPS - Zona de Proteção Sustentável',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/b8cd85b9-c98f-4b85-9551-ccd2a0e13ee5/download/zps.geojson',
      style: {
         fillColor: 'rgba(181, 139, 94, 0.2)',
         color: '#B58B5E',
         weight: 2,
      }
    },
    {
      id: 'layer52',
      name: 'ZR - Zona Rural',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/2343bd78-9252-40a2-921a-444686ce57d9/download/zr.geojson',
      style: {
         fillColor: 'rgb(183, 234, 181, 0.2)',
         color: '#B7EAB5',
         weight: 2,
      }
    },
    {
      id: 'layer53',
      name: 'ZUE - Zona Urbana Especial',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/56d6624a-b82f-4bde-8a5f-002b6aa6ed72/download/zue.geojson',
      style: {
         fillColor: 'rgba(114, 155, 111, 0.2)',
         color: '#729B6F',
         weight: 2,
      }
    },
    {
      id: 'layer54',
      name: 'ZUS II - Zona de Uso Sustentável II',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/ed929ffb-86c8-455c-aeb6-1e472101e506/download/zus_ii.geojson',
      style: {
         fillColor: 'rgba(125, 139, 143, 0.2)',
         color: '#7D8B8F',
         weight: 2,
      }
    },
    {
      id: 'layer55',
      name: 'ZEIS II - Zona de Interesse Social II',
      type: 'polygon',
      url: API_URL + '/dataset/cc46306b-0493-43ee-99ab-6e733f31396f/resource/c1e4b0b6-8f0d-4886-9306-c7c96469eca5/download/zeis_ii.geojson',
      style: {
         fillColor: 'rgba(27, 116, 184, 0.2)',
         color: '#1B74B8',
         weight: 2,
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
  let inscricaoSearchQuery = '';
  let inscricaoSearchResults = [];
  let logradouroSearchQuery = '';
  let logradouroSearchResults = [];
  let inscricaoData = null; // Will store layer14 data for searching

  // Create custom logo control
  const LogoControl = L.Control.extend({
    onAdd: function(map) {
      const container = L.DomUtil.create('div', 'logo-control');
      const img = L.DomUtil.create('img', 'logo-image', container);
      img.alt = 'Curvelo Aberta';

      img.src = 'https://dados.curvelo.mg.gov.br/uploads/admin/2025-02-06-052313.446052curvelo-aberta-logo.png';
      img.onclick = () => window.open('https://dados.curvelo.mg.gov.br', '_blank');

      // Prevent click events from propagating to the map
      L.DomEvent.disableClickPropagation(container);
      return container;
    }
  });
  
  // Create location button control
  const LocationControl = L.Control.extend({
    onAdd: function(map) {
      const container = L.DomUtil.create('div', 'location-control');
      const button = L.DomUtil.create('button', 'location-button', container);
      button.innerHTML = '📍';
      button.title = 'Ir para minha localização';
      
      button.onclick = () => {
        if (navigator.geolocation) {
          button.classList.add('loading');
          navigator.geolocation.getCurrentPosition(
            (position) => {
              const { latitude, longitude } = position.coords;
              map.setView([latitude, longitude], 16);
              
              // Show a marker at user location
              const userLocationMarker = L.circleMarker([latitude, longitude], {
                radius: 8,
                fillColor: '#4285F4',
                color: '#FFFFFF',
                weight: 2,
                opacity: 1,
                fillOpacity: 1
              }).addTo(map);
              
              // Remove loading state
              button.classList.remove('loading');
            },
            (error) => {
              console.error('Error getting location:', error);
              alert('Não foi possível obter sua localização. Verifique se você permitiu o acesso à localização.');
              button.classList.remove('loading');
            },
            { 
              enableHighAccuracy: true,
              timeout: 5000,
              maximumAge: 0
            }
          );
        } else {
          alert('Seu navegador não suporta geolocalização.');
        }
      };
      
      // Prevent click events from propagating to the map
      L.DomEvent.disableClickPropagation(container);
      return container;
    }
  });

  onMount(() => {

    var satellite = L.tileLayer('http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}', {
      maxNativeZoom: 22,
      maxZoom: 22,
      subdomains:['mt0','mt1','mt2','mt3']
    });

    var osm = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxNativeZoom: 19,
      maxZoom: 22,
      attribution: '© OpenStreetMap contributors',
    });

    map = L.map('map', {maxNativeZoom: 19, layers: [satellite, osm]}).setView([-18.7587401,-44.46470720], 12);

    var baseMaps = {
      "Satélite": satellite,
      "OpenStreetMap": osm,
    };


    new LogoControl({ position: 'topright' }).addTo(map);
    new LocationControl({ position: 'bottomright' }).addTo(map);
    var layerControl = L.control.layers(baseMaps).addTo(map);


  });

  function createLayerGroup(config, geojsonData) {
    switch(config.type) {
      case 'icon':
        const customIcon = L.icon({
          iconUrl: config.iconUrl,
          iconSize: config.iconSize || [32, 32],
          iconAnchor: config.iconAnchor || [16, 32],
          popupAnchor: config.popupAnchor || [0, -32]
        });
        
        const markerCluster = L.markerClusterGroup({
          chunkedLoading: true,
          maxClusterRadius: 50,
          spiderfyOnMaxZoom: false,
          disableClusteringAtZoom: 14
        });

        L.geoJSON(geojsonData, {
          pointToLayer: (feature, latlng) => {
            return L.marker(latlng, { icon: customIcon });
          },
          onEachFeature: (feature, layer) => {
            if (feature.properties) {
              layer.bindPopup(() => {
                return formatPopupContent(feature.properties);
              }, { maxHeight: 200 });
            }
          }
        }).addTo(markerCluster);

        return markerCluster;
        
      case 'point':
        const pointMarkerCluster = L.markerClusterGroup({
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
              }, { maxHeight: 200 });
            }
          }
        }).addTo(pointMarkerCluster);

        return pointMarkerCluster;

      case 'polygon':
      case 'line':
        return L.geoJSON(geojsonData, {
          style: config.style,
          onEachFeature: (feature, layer) => {
            if (feature.properties) {
              layer.bindPopup(() => {
                return formatPopupContent(feature.properties);
              }, { maxHeight: 200 });
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
      
      // If this is the inscricao layer (layer14), store its data for searching
      if (config.id === 'layer14') {
        inscricaoData = data;
      }

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

  function toggleLayerGroup (event) {
    event.target.nextElementSibling.classList.toggle("layer-collapsed");
  }

  function toggleMenu() {
    isMenuCollapsed = !isMenuCollapsed;
  }
  
  // Search for inscricao in layer14
  function searchInscricao() {
    if (!inscricaoData || !inscricaoSearchQuery.trim()) {
      inscricaoSearchResults = [];
      return;
    }
    
    // Normalize the search query (remove spaces, convert to lowercase)
    const normalizedQuery = inscricaoSearchQuery.trim().toLowerCase().replace(/\s+/g, '');
    
    // Search for matching inscricao in features
    inscricaoSearchResults = inscricaoData.features
      .filter(feature => {
        // Check if the feature has properties and inscricao property
        if (!feature.properties || !feature.properties.Inscricao) return false;
        
        // Normalize the inscricao value
        const inscricao = String(feature.properties.Inscricao).toLowerCase().replace(/\s+/g, '');
        
        // Return true if the inscricao includes the search query
        return inscricao.includes(normalizedQuery);
      })
      .slice(0, 5); // Limit to 5 results for performance
  }
  
  // Search for logradouro in layer14
  function searchLogradouro() {
    if (!inscricaoData || !logradouroSearchQuery.trim()) {
      logradouroSearchResults = [];
      return;
    }
    
    // Normalize the search query (remove spaces, convert to lowercase)
    const normalizedQuery = logradouroSearchQuery.trim().toLowerCase().replace(/\s+/g, '');
    
    // Search for matching logradouro in features
    logradouroSearchResults = inscricaoData.features
      .filter(feature => {
        // Check if the feature has properties and Logradouro property
        if (!feature.properties || !feature.properties.Logradouro) return false;
        
        // Normalize the logradouro value
        const logradouro = String(feature.properties.Logradouro).toLowerCase().replace(/\s+/g, '');
        
        // Return true if the logradouro includes the search query
        return logradouro.includes(normalizedQuery);
      })
      .slice(0, 5); // Limit to 5 results for performance
  }
  
  // Go to the location of a specific feature
  function goToFeature(feature) {
    if (!feature || !feature.geometry || !feature.geometry.coordinates) return;
    
    // Make sure layer14 is visible
    if (!selectedLayers.has('layer14')) {
      // Find layer14 config
      const layer14Config = layerConfig.find(config => config.id === 'layer14');
      if (layer14Config) {
        toggleLayer(layer14Config);
      }
    }
    
    // For point features, coordinates are [longitude, latitude]
    const [longitude, latitude] = feature.geometry.coordinates;
    
    // Set the view to the coordinates with zoom level 18
    map.setView([latitude, longitude], 18);
    
    // Add a temporary highlight marker
    const highlightMarker = L.circleMarker([latitude, longitude], {
      radius: 15,
      color: '#FF4500',
      weight: 3,
      opacity: 1,
      fillColor: '#FF4500',
      fillOpacity: 0.3,
      pulsing: true
    }).addTo(map);
    
    // Create a popup with feature properties
    const popupContent = formatPopupContent(feature.properties);
    highlightMarker.bindPopup(popupContent, { maxHeight: 200 }).openPopup();
    
    // Remove the highlight marker after 5 seconds
    // setTimeout(() => {
    //   map.removeLayer(highlightMarker);
    // }, 5000);
    
    // Clear search results
    inscricaoSearchResults = [];
    inscricaoSearchQuery = '';
    logradouroSearchResults = [];
    logradouroSearchQuery = '';
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
  
  :global(.location-button) {
    width: 40px;
    height: 40px;
    background-color: white;
    border: 2px solid rgba(0,0,0,0.2);
    border-radius: 4px;
    box-shadow: 0 1px 5px rgba(0,0,0,0.4);
    cursor: pointer;
    font-size: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s ease;
  }
  
  :global(.location-button:hover) {
    background-color: #f4f4f4;
  }
  
  :global(.location-button.loading) {
    pointer-events: none;
    opacity: 0.7;
    animation: pulse 1.5s infinite;
  }
  
  @keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); }
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

  .curvelo-mapas-logo {
    width: 100%;
    text-align: center;

    img {
      max-width: 100px;
    }
  }

  .layer-group {
    overflow: hidden;
    max-height: 0;
  }

  .layer-collapsed {
    max-height: 100%;
    transition: max-height 0.3s ease-out;

  }

  .about-link {
    margin-top: 20px;
    width: 100%; 
    text-align: center;
  }
  
  .search-container {
    margin-top: 10px;
    margin-bottom: 10px;
    width: 100%;
    padding: 0 10px;
  }
  
  .search-input {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }
  
  .search-results {
    margin-top: 5px;
    width: 100%;
    max-height: 200px;
    overflow-y: auto;
    background-color: white;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }
  
  .search-result-item {
    padding: 8px 10px;
    cursor: pointer;
    transition: background-color 0.2s;
    border-bottom: 1px solid #eee;
  }
  
  .search-result-item:hover {
    background-color: #f0f0f0;
  }
  
  .search-result-item:last-child {
    border-bottom: none;
  }
  
  .search-title {
    font-weight: bold;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
  }
  
  .search-icon {
    margin-right: 5px;
  }
</style>

<div class="container">
  <div class="menu {isMenuCollapsed ? 'collapsed' : 'expanded'}">
    <div class="menu-content">

      <div class="curvelo-mapas-logo">
        <img src={curveloLogo}>
      </div>
      
      <!-- Search tools - only visible when layer14 is selected -->
      {#if selectedLayers.has('layer14')}
        <!-- Inscricao Search -->
        <div class="search-container">
          <div class="search-title">
            <span class="search-icon">🔍</span> Buscar inscrição cadastral
          </div>
          <input 
            type="text" 
            class="search-input" 
            placeholder="Digite a inscrição..." 
            bind:value={inscricaoSearchQuery}
            on:input={searchInscricao}
          />
          
          {#if inscricaoSearchResults.length > 0}
            <div class="search-results">
              {#each inscricaoSearchResults as result}
                <div class="search-result-item" on:click={() => goToFeature(result)}>
                  Inscrição: {result.properties.Inscricao}
                </div>
              {/each}
            </div>
          {:else if inscricaoSearchQuery.trim() !== '' && inscricaoData}
            <div class="search-results">
              <div class="search-result-item">Nenhum resultado encontrado</div>
            </div>
          {/if}
        </div>
        
        <!-- Logradouro Search -->
        <div class="search-container">
          <div class="search-title">
            <span class="search-icon">🔍</span> Buscar por logradouro
          </div>
          <input 
            type="text" 
            class="search-input" 
            placeholder="Digite o nome da rua..." 
            bind:value={logradouroSearchQuery}
            on:input={searchLogradouro}
          />
          
          {#if logradouroSearchResults.length > 0}
            <div class="search-results">
              {#each logradouroSearchResults as result}
                <div class="search-result-item" on:click={() => goToFeature(result)}>
                  {result.properties.Logradouro}, {result.properties.Num_Imovel || 'S/N'}
                </div>
              {/each}
            </div>
          {:else if logradouroSearchQuery.trim() !== '' && inscricaoData}
            <div class="search-results">
              <div class="search-result-item">Nenhum resultado encontrado</div>
            </div>
          {/if}
        </div>
      {/if}
      
      <div class="layers">
      {#each layerGroups as layerGroup}
        <h3 on:click={event => toggleLayerGroup(event)}>{layerGroup['name']} ({layerGroup['layers'].length})</h3>
        <div class="layer-group">
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
        </div>

      {/each}
      </div>
      <div class="about-link"><a href="https://dados.curvelo.mg.gov.br/sobre">Sobre o Curvelo em Mapas</a></div>

    </div>
    <button class="toggle-button" on:click={toggleMenu}>
      <span class="toggle-icon"></span>
    </button>
  </div>
  
  <div class="map-container">
    <div id="map"></div>
  </div>
</div>
