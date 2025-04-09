// vec3 opRepeat(in vec3 pos, in vec3 size) {
//     return mod(pos + 0.5 * size, size) - 0.5 * size;
// }

struct Grid {
    /** Local UV coordinates of the cell. */
    vec3 localUv;
    
    /** Identifier to differentiate between cells. */
    vec3 cellId;
};

Grid opRepeat(in vec3 pos, in vec3 space) {
    vec3 id = floor(pos / space);
    vec3 uv = mod(pos + (space * .5), space) - (space * .5);

    return Grid(uv, id);
}
