from glob import glob
from tqdm import tqdm
import re

def preprocess_ofrom(corpus_path, output_file_path):
    print("Loading the OFROM...")
    src_txt_files = glob(f"{corpus_path}/*.txt")
    output = []
    print(f"Processing {len(src_txt_files)} files")
    for src_txt_file in tqdm(src_txt_files, desc="Processing"):
        y = 0 #imported sentences number per file
        #print(f"Opening {src_txt_file}...")
        with open(src_txt_file, 'r') as src_txt:
            txt = src_txt.read()
            #print(f"File is {len(txt)} lines long.")
            for src_txt_line in txt.replace("# ", " # ").replace(" #", " # ").split(" # "):
                #print(src_txt_line)
                if src_txt_line:
                    src_txt_line_content_list = src_txt_line.replace("@ ", " @ ").replace("@", " @ ").split(" @ ")
                    for src_txt_line_content in src_txt_line_content_list:
                        _text = src_txt_line_content.replace(" % ", "").replace("% ", "").replace(" %", "").replace("%", " ")
                        #print(f"Processing: {src_txt_line_content}")
                        flt = re.compile(r'[ ]?\(\d+\.\d+\)[ ]?')
                        usr = re.compile(r'[a-z0-9]+-[a-z0-9]+ :\t')
                        sw = re.compile(r'([a-z]?)\/')

                        #_text = src_txt_line_content.replace("/ ", "")
                        _text = re.sub(flt, r'\n', _text)
                        _text = re.sub(usr, "", _text)
                        _text = re.sub(sw, "", _text)

                        for _lt in _text.split("\n"):
                            if _lt:
                                if _lt not in [" ", "%"]:
                                    if _lt.startswith(" "):
                                        _lt = _lt[1:]
                                    #print(f"Content: {_lt}")
                                    output.append(_lt)
                                    y += 1
                    
                        #print(f"Not Content: {src_txt_line_content}")
                #else:
                    #print(f"Line `{src_txt_line}` has no sentences.")
        #print(f"Closing {src_txt_file} with {y} sentences imported.")
    
    print(f"Collected {len(output)} sentences.")
    #print("Saving sentences...")
    with open(output_file_path, 'w') as output_file:
        output_file.write("\n".join(output).lower())
    print(f"Task is completed: file save @ {output_file_path}")


def main(args):
    corpus_path = args.corpus_path[0]
    output_file = args.output_file[0]
    preprocess_ofrom(corpus_path, output_file)

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('corpus_path', nargs=1, type=str, help="Path to OFROM_txt path")
    parser.add_argument('output_file', nargs=1, type=str, help="Path to output file path")
    args = parser.parse_args()
    
    main(args)

