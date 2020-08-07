'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "sitemap.xml": "b2f40351e323222a84e1ff698d2b0722",
"icons/Icon-192.png": "45c7fed5dd705ac7a6d6c3ee85e1bd05",
"icons/Icon-512.png": "97bfe21637a568015f5dacb71fe2e756",
"favicon.png": "97bfe21637a568015f5dacb71fe2e756",
"main.dart.js": "5a3dc41899a73631eb58a34f4f4e7211",
"index.html": "ac20250f360a57e6810665db213610ed",
"/": "ac20250f360a57e6810665db213610ed",
"manifest.json": "9558bafe33c07b36cd2b14df157862e9",
"assets/FontManifest.json": "c5524c29ab112b6c8ad2e572cadc0df2",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/packages/flutter_brand_icons/fonts/brands.ttf": "c68086e056cc711231ec09ea8b005516",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "d51b09f7b8345b41dd3b2201f653c62b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "51d23d1c30deda6f34673e0d5600fd38",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "0ea892e09437fcaa050b2b15c53173b7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/AssetManifest.json": "f78ebccdb7029f4f7ed012356a34290e",
"assets/NOTICES": "f1d8eaca7a512d0054c71f5a72328673",
"assets/assets/images/projects/Cards%2520Carousel.png": "b26fa69eb800889f1df412858c57bb1d",
"assets/assets/images/projects/APCOM%2520%25E8%25AD%25B0%25E7%25A8%258B%25E7%25B6%25B2%25E9%25A0%2581.png": "08414a5545c7d62d1fbc864fab6a1f8e",
"assets/assets/images/projects/TSA%2520Handbook.png": "94ed67bbc1883767efd6ff02c7cacd53",
"assets/assets/images/projects/%25E6%259C%25AA%25E4%25BE%2586%25E7%25A7%2591%25E6%258A%2580%25E5%25B1%2595%25E5%25BE%25AE%25E7%25B5%2590%25E6%25A7%258B%25E8%25A8%25AD%25E8%25A8%2588%25E6%2588%2590%25E6%259E%259C%25E5%25B1%2595%25E7%25A4%25BA%25E5%25B9%25B3%25E5%258F%25B0.png": "214f3dd91083c40bc8db6bcd60d7c97d",
"assets/assets/images/projects/BIM%2520%25E7%25AE%25A1%25E7%2590%2586%25E5%25B9%25B3%25E5%258F%25B0.png": "7e928dc9f0d74814eef6da46ad48b95e",
"assets/assets/images/projects/Palette%2520Manager.png": "4eb153fe1dab40dd83f3133962f30013",
"assets/assets/images/projects/Workshop%2520Slides%2520and%2520Examples.png": "52116754785c90a567a201a3be7d29c2",
"assets/assets/images/projects/Color%2520Editor.png": "f95a821a68b852ef06689ea5fa438ec7",
"assets/assets/images/profile.JPG": "8ef0c1974af57dfd50cd285ec88293e1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
