class WalkerFarm {
    int numberOfWalkers = 500;
    IntVector minBound, maxBound;
    ArrayList<Walker> walkers;
    IntList removeList;

    WalkerFarm(int _minX, int _minY, int _maxX, int _maxY) {
        minBound = new IntVector(_minX, _minY);
        maxBound = new IntVector(_maxX, _maxY);

        removeList = new IntList();

        walkers = new ArrayList<Walker>();

        for (int i = 0; i < numberOfWalkers; i ++) {

            newWalker();
        }
    }


    public void draw() {

        removeList.clear();

        for (Walker w : walkers) {
            w.update();
            w.draw();

            // If a walker has left the screen, add it's ID into a list of walkers to be removed
            if (w.position.x > maxBound.x || w.position.x < minBound.x || w.position.y > maxBound.y || w.position.y < minBound.x) {
                removeList.append(walkers.indexOf(w));
            }
        }


        // Run through the remove list and replace the departed walkers with new baby walkers
        int walkersToAdd = removeList.size();
        for (int i = 0; i < walkersToAdd; i++) {
            walkers.remove(removeList.get(i));

            newWalker();
        }
    }

    void newWalker() {
        color wc = color(random(360), 100, 100, 10);
        int wx = irandom(maxBound.x);
        int wy = irandom(maxBound.y);

        walkers.add(new BasicWalker(wx, wy, wc));
    }
}
