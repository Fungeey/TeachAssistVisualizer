using System.Collections.Generic;
using UnityEngine;

[RequireComponent (typeof(AudioSource))]
public class PieController : MonoBehaviour {
	public float MaxScale = 150;
	public List<SectionDisplayer> sections;
	AudioSource audioSource;
	public float[] samples = new float[512];

	void Start () {
		audioSource = GetComponent<AudioSource>();
	}
	
	void Update () {
		GetSpectrumAudioSource();

		for (int i = 0; i < sections.Count; i++) {
			SectionDisplayer s = sections[i];
			s.Value = (int)(samples[(int)Mathf.Pow(1.46f, i)] * MaxScale * 100);
		}

		for (int i = 1; i < samples.Length - 1; i++) {
			Debug.DrawLine(new Vector3(i - 1, samples[i] + 10, 0), new Vector3(i, samples[i + 1] + 10, 0), Color.red);
			Debug.DrawLine(new Vector3(i - 1, Mathf.Log(samples[i - 1]) * 10, 2), new Vector3(i, Mathf.Log(samples[i]) * 10, 2), Color.cyan);
			Debug.DrawLine(new Vector3(Mathf.Log(i - 1), samples[i - 1] - 10, 1), new Vector3(Mathf.Log(i), samples[i] - 10, 1), Color.green);
			Debug.DrawLine(new Vector3(Mathf.Log(i - 1), Mathf.Log(samples[i - 1]), 3), new Vector3(Mathf.Log(i), Mathf.Log(samples[i]), 3), Color.blue);
		}
	}

	private void GetSpectrumAudioSource() {
		audioSource.GetSpectrumData(samples, 0, FFTWindow.Blackman);
	}
}
