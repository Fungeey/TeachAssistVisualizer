using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[ExecuteInEditMode]
public class SectionDisplayer : MonoBehaviour {

	public List<Sprite> sprites;
	public SpriteRenderer renderer;

	private const int maxBuffer = 5;
	public int Value {
		get {
			if (buffer.Count == 0)
				return 0;
			return (int)Mathf.Min((float)buffer.Average(), 99);
		}
		set {
			if(buffer.Count > maxBuffer)
				buffer.Dequeue();
			buffer.Enqueue(value);
		}
	}
	private int _value;

	private Queue<int> buffer = new Queue<int>();

	void Update () {
		renderer.sprite = sprites[Value];
	}
}
